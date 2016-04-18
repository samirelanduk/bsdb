import pygtop
import utilities
print("")

print("Obtaining ligands from GtoP...")
ligands = pygtop.get_all_ligands()

print("Obtaining interactions from GtoP...")
interactions = []
for ligand in ligands[:10]:
    interactions += ligand.get_interactions()
print("There are %i interactions." % len(interactions))

connection = utilities.get_connection()
print("There are %i interactions already in the staging database."
 % utilities.get_interactions_row_count(connection))

interaction_ids_in_table = utilities.get_interaction_ids_from_table(connection)

interactions_added = 0
interactions_modified = 0
for interaction in interactions:
    if interaction.interaction_id not in interaction_ids_in_table:
        utilities.add_interaction_to_table(interaction, connection)
        interactions_added += 1
    elif utilities.interaction_differs_from_table(interaction, connection):
        utilities.update_interaction(interaction, connection)
        interactions_modified += 1
print("Added %i rows to the interactions table." % interactions_added)
print("Modified %i rows in the interactions table." % interactions_modified)
print("The interactions table now has %i interactions."
 % utilities.get_interactions_row_count(connection))


connection.close()
print("")