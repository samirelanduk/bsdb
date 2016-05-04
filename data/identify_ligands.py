import biosci
import pygtop
import utilities
print("")

connection = utilities.get_connection()
with utilities.get_connection() as connection:
    print("Getting all Interaction-PDB maps in the staging database...")
    interaction_pdb_maps = utilities.get_interaction_pdb_maps(connection)
    print("There are %i Interaction-PDB maps." % len(interaction_pdb_maps))


    print("")
