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
finally:
    connection.close()
    print("")
