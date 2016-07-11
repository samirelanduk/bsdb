import molecupy
import pygtop
import utilities
print("")

connection = utilities.get_connection()
try:
    print("Getting all Interaction-PDB maps in the staging database...")
    interaction_pdb_maps = utilities.get_interaction_pdb_maps(connection)
    print("There are %i Interaction-PDB maps." % len(interaction_pdb_maps))

    interaction_pdb_maps = [
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map["hetId"]
    ]
    print("There are %i Interaction-PDB maps with no HET." % len(interaction_pdb_maps))

    print("Looking for HETs...")
    for pdb_map in interaction_pdb_maps:
        interaction = pygtop.get_target_by_id(
         pdb_map["targetId"]).get_interaction_by_id(
          pdb_map["interactionId"])
        ligand = interaction.ligand()
        print("\t%i%s: Looking for %s in PDB %s..." % (
         pdb_map["interactionId"], pdb_map["pdbCode"], ligand.name(), pdb_map["pdbCode"]
        ), end=" ")
        pdb = molecupy.get_pdb_remotely(pdb_map["pdbCode"])
        molecule = ligand.find_in_pdb_by_smiles(pdb)
        if not molecule:
            molecule = ligand.find_in_pdb_by_name(pdb)
        if not molecule:
            molecule = ligand.find_in_pdb_by_mass(pdb)
        if not molecule:
            molecule = ligand.find_in_pdb_by_peptide_string(pdb)
        if molecule:
            try:
                name = molecule.molecule_id
            except:
                name = molecule.chain_id
            print(name)
            utilities.give_pdb_map_het_code(
             pdb_map["interactionId"], pdb_map["pdbCode"], name, connection
            )
        else:
            print("Not found")

finally:
    connection.close()
    print("")
