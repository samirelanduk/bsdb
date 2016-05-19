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
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map[4]
    ]
    print("There are %i Interaction-PDB maps with no binding site." % len(
     interaction_pdb_maps
    ))

    print("Looking for binding sites...")
    for pdb_map in interaction_pdb_maps:
        pdb = molecupy.get_pdb_remotely(pdb_map[2])
        ligand = pdb.model.get_small_molecule_by_id(pdb_map[3])
        print("\t%i%s: Looking for %s's binding site in PDB %s..." % (
         pdb_map[1], pdb_map[2], ligand, pdb_map[2]
        ), end=" ")
finally:
    connection.close()
    print("")
