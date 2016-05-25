import pygtop
import utilities
import sys
print("")

flag_unknown = False
del_unknown = False
if len(sys.argv) > 1:
    if sys.argv[1] == "flagunknown":
        flag_unknown = True
    elif sys.argv[1] == "delunknown":
        del_unknown = True
    else:
        print("Unkown argument: %s\n" % sys.argv[1])
        sys.exit()

print("Obtaining targets from GtoP...")
targets = pygtop.get_all_targets()

print("Obtaining interactions from GtoP...")
interactions = []
for target in targets[1000:1005]:
    interactions += target.get_interactions()
print("There are %i interactions currently in GtoP." % len(interactions))

connection = utilities.get_connection()
print("There are %i interactions already in the BSDB staging database."
 % utilities.get_interactions_row_count(connection))

interaction_ids_in_table = utilities.get_interaction_ids_from_table(connection)

interactions_added = 0
interactions_modified = 0
print("Updating stage database with interactions...")
for interaction in interactions:
    if interaction.interaction_id not in interaction_ids_in_table:
        utilities.add_interaction_to_table(interaction, connection)
        interactions_added += 1
    elif utilities.interaction_differs_from_table(interaction, connection):
        utilities.update_interaction(interaction, connection)
        interactions_modified += 1

interactions_removed = 0
if flag_unknown or del_unknown:
    object_ids = [interaction.interaction_id for interaction in interactions]
    for row_id in interaction_ids_in_table:
        if row_id not in object_ids:
            if flag_unknown:
                print(
                 "\tInteraction %i exists in the BSDB stage database but doesn't seem to be in GtoP any longer."
                  % row_id
                )
            elif del_unknown:
                utilities.remove_interaction_row_by_id(row_id, connection)
                interactions_removed += 1


print("Added %i rows to the interactions table." % interactions_added)
print("Modified %i rows in the interactions table." % interactions_modified)
print("Removed %i rows from the interactions table." % interactions_removed)
print("The interactions table now has %i interactions."
 % utilities.get_interactions_row_count(connection))


connection.close()
print("")
