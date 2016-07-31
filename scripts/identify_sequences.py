import molecupy
from molecupy.structures.chains import BindSite, RESIDUES
import utilities
import warnings
print("")

connection = utilities.get_connection()
try:
    print("Getting all Interaction-PDB maps in the staging database...")
    interaction_pdb_maps = utilities.get_interaction_pdb_maps(connection)
    print("There are %i Interaction-PDB maps." % len(interaction_pdb_maps))



    interaction_pdb_maps = [
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map["bindSequence"] and pdb_map["bindingResidues"]
    ]
    print("There are %i Interaction-PDB maps with no bind sequence." % len(
     interaction_pdb_maps
    ))

    print("Looking for bind sequences...")
    for pdb_map in interaction_pdb_maps:
        warnings.simplefilter("ignore")
        try:
            pdb = molecupy.get_pdb_remotely(pdb_map["pdbCode"])
            ligand_is_peptide = len(pdb_map["hetId"]) == 1
            ligand = pdb.model().get_chain_by_id(pdb_map["hetId"]) if ligand_is_peptide\
             else pdb.model().get_small_molecule_by_id(pdb_map["hetId"])
            print("\t%i%s: Looking for %s's bind sequence in PDB %s..." % (
             pdb_map["interactionId"], pdb_map["pdbCode"], ligand, pdb_map["pdbCode"]
            ), end=" ")
            binding_residue_ids = pdb_map["bindingResidues"].split(", ")
            binding_residues = []
            for binding_residue_id in binding_residue_ids:
                if binding_residue_id[0].isalpha():
                    chain = pdb.model().get_chain_by_id(binding_residue_id[0])
                    if chain and chain.residues():
                        residue = chain.get_residue_by_id(binding_residue_id)
                        if residue:
                            binding_residues.append(residue)
            if len(set([binding_residue.chain().chain_id() for binding_residue in binding_residues])) == 1: # Esure all residues on same chain
                chain = binding_residues[0].chain()
                binding_residues = sorted(binding_residues, key=lambda k: chain.residues().index(k))
                site = BindSite("site", *binding_residues)

                sequence = site.continuous_sequence()

                if len(sequence.residues(include_missing=False)) / len(sequence.residues(include_missing=True)) <= 0.95:
                    print("Can't - sequence is missing too many residues (%i of %i missing)" % (
                     len(sequence.residues(include_missing=True)) - len(sequence.residues(include_missing=False)),
                     len(sequence.residues(include_missing=True))
                    ))
                else:
                    sequence_string = "".join([
                     RESIDUES.get(res.residue_name(), "X") if res in binding_residues else
                      RESIDUES.get(res.residue_name(), "x").lower() for res in chain.residues()
                    ])
                    chain_length = len(sequence_string)
                    internal_contacts = len(sequence.internal_contacts())
                    external_contacts = len(sequence.contacts_with(chain))
                    residue_ids = ",".join([res.residue_id() for res in sequence.residues()])
                    utilities.give_pdb_map_bind_sequence(
                     pdb_map["interactionId"], pdb_map["pdbCode"],
                     sequence_string,
                     chain.chain_id(),
                     len(sequence_string),
                     len(sequence.residues()) / chain_length,
                     internal_contacts,
                     external_contacts,
                     internal_contacts / external_contacts,
                     residue_ids,
                     connection
                    )

                    print("Found %i residue sequence on chain %s" % (
                     len(sequence_string), chain.chain_id()
                    ))
            else:
                print("Can't - residues on different chains")
        except molecupy.InvalidPdbCodeError:
            print("\t%s not found" % pdb_map["pdbCode"])

finally:
    connection.close()
    print("")
