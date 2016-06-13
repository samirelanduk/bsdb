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
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map["bindSequence"] and pdb_map["bindingResidues"]
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
        binding_residue_ids = pdb_map["bindingResidues"].split(", ")
        binding_residues = []
        for binding_residue_id in binding_residue_ids:
            if binding_residue_id[0].isalpha():
                chain = pdb.model.get_chain_by_id(binding_residue_id[0])
                if chain and chain.residues:
                    residue = chain.get_residue_by_id(binding_residue_id)
                    if residue:
                        binding_residues.append(residue)
        if len(set([binding_residue.chain.chain_id for binding_residue in binding_residues])) == 1: # Esure all residues on same chain
            chain = binding_residues[0].chain
            binding_residues = sorted(binding_residues, key=lambda k: chain.residues.index(k))
            print([r.residue_id for r in binding_residues])
            sequence_residues = [binding_residues[0]]
            while sequence_residues[-1].downstream_residue:
                sequence_residues.append(sequence_residues[-1].downstream_residue)
                if sequence_residues[-1] is binding_residues[-1]:
                    break
            if binding_residues[-1] is not sequence_residues[-1]:
                print("Can't - sequence is missing residues")
            else:
                sequence = ResiduicSequence(*sequence_residues)
                sequence_string = "".join([
                 RESIDUES.get(res.residue_name, "x") if res in binding_residues else
                  RESIDUES.get(res.residue_name, "x").lower() for res in sequence.residues
                ])
                chain_length = len(chain.residues) + len(chain.missing_residues)
                internal_contacts = len(sequence.get_internal_contacts())
                external_contacts = len(sequence.get_external_contacts_with(chain))
                residue_ids = ",".join([res.residue_id for res in sequence.residues])
                utilities.give_pdb_map_bind_sequence(
                 pdb_map["interactionId"], pdb_map["pdbCode"],
                 sequence_string,
                 chain.chain_id,
                 len(sequence_string),
                 len(sequence_string) / chain_length,
                 internal_contacts,
                 external_contacts,
                 internal_contacts / external_contacts,
                 residue_ids,
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
