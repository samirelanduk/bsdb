import pygtop
import utilities
import datetime
print("")

connection = utilities.get_connection()

print("Getting interactions that have never been checked for PDBs...")
unchecked_interactions = [
 pygtop.get_target_by_id(target_id).get_interaction_by_id(interaction_id)
  for interaction_id, target_id
   in utilities.get_interaction_ids_never_checked_for_pdbs(connection)
]
print("There are %i such interactions." % (len(unchecked_interactions)))

print("Assigning PDBs to unchecked interactions...")
while unchecked_interactions:
    interaction = unchecked_interactions.pop()
    print("\tChecking %s" % str(interaction))
    pdbs = interaction.find_all_pdbs()

print("")
connection.close()
