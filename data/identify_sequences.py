import molecupy
from molecupy.structures import ResiduicSequence, RESIDUES, ResiduicStructure
import utilities
print("")

connection = utilities.get_connection()
try:
    print("Getting all Interaction-PDB maps in the staging database...")
    interaction_pdb_maps = utilities.get_interaction_pdb_maps(connection)
    print("There are %i Interaction-PDB maps." % len(interaction_pdb_maps))

    interaction_pdb_maps = [
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map["bindSequence"]
    ]
    print("There are %i Interaction-PDB maps with no bind sequence." % len(
     interaction_pdb_maps
    ))

    print("Looking for bind sequences...")
    for pdb_map in interaction_pdb_maps:
        pdb = molecupy.get_pdb_remotely(pdb_map["pdbCode"])
        ligand = pdb.model.get_small_molecule_by_id(pdb_map["het"])
        print("\t%i%s: Looking for %s's bind sequence in PDB %s..." % (
         pdb_map["interactionId"], pdb_map["pdbCode"], ligand, pdb_map["pdbCode"]
        ), end=" ")
        residue_ids = pdb_map["bindingResidues"].split(", ")
        residues = []
        for residue_id in residue_ids:
            if residue_id[0].isalpha():
                chain = pdb.model.get_chain_by_id(residue_id[0])
                if chain and chain.residues:
                    residue = chain.get_residue_by_id(residue_id)
                    if residue:
                        residues.append(residue)
        if len(set([residue.chain.chain_id for residue in residues])) == 1:
            chain = residues[0].chain
            residues = sorted(residues, key=lambda k: chain.residues.index(k))
            sequence_residues = [residues[0]]
            while sequence_residues[-1].downstream_residue:
                sequence_residues.append(sequence_residues[-1].downstream_residue)
                if sequence_residues[-1] is residues[-1]:
                    break
            if residues[-1] is not sequence_residues[-1]:
                print("Can't - sequence is missing residues")
            else:
                sequence = ResiduicSequence(*sequence_residues)
                sequence_string = "".join([
                 RESIDUES.get(res.residue_name, "x") if res in residues else
                  RESIDUES.get(res.residue_name, "x").lower() for res in sequence.residues
                ])
                chain_length = len(chain.residues) + len(chain.missing_residues)
                internal_contacts = len(sequence.get_internal_contacts())
                external_contacts = len(sequence.get_external_contacts_with(chain))
                non_sequence = ResiduicStructure(*[
                 residue for residue in chain.residues if residue not in sequence.residues
                ])
                residue_internal_contacts = [
                 len(residue.get_external_contacts_with(sequence)) for residue in sequence.residues
                ]
                residue_external_contacts = [
                 len(residue.get_external_contacts_with(non_sequence)) for residue in sequence.residues
                ]
                utilities.give_pdb_map_bind_sequence(
                 pdb_map["interactionId"], pdb_map["pdbCode"],
                 sequence_string,
                 chain.chain_id,
                 len(sequence_string),
                 len(sequence_string) / chain_length,
                 internal_contacts,
                 external_contacts,
                 internal_contacts / external_contacts,
                 residue_internal_contacts,
                 residue_external_contacts,
                 connection
                )

                print("Found %i residue sequence on chain %s" % (
                 len(sequence_string), chain.chain_id
                ))
        else:
            print("Can't - residues on different chains")

finally:
    connection.close()
    print("")
