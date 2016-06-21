import pygtop
import utilities
import datetime
import sys
print("")

check_previous = False
if len(sys.argv) > 1:
    if sys.argv[1] == "checkprev":
        check_previous = True
    else:
        print("Unkown argument: %s\n" % sys.argv[1])
        sys.exit()

connection = utilities.get_connection()

print("Getting interaction objects that have never been checked for PDBs...")
unchecked_interactions = [
 pygtop.get_target_by_id(target_id).get_interaction_by_id(interaction_id)
  for interaction_id, target_id
   in utilities.get_interaction_ids_never_checked_for_pdbs(connection)
]
never_checked_ids = [i.interaction_id for i in unchecked_interactions]
print("There are %i such interactions." % (len(unchecked_interactions)))

if unchecked_interactions:
    interactions_assigned_count = 0
    pdbs_assigned_count = 0
    print("Assigning PDBs to unchecked interactions...")
    while unchecked_interactions:
        interaction = unchecked_interactions.pop()
        print("\tChecking %s" % str(interaction), end=" ")
        pdbs = interaction.find_all_pdbs()
        pdbs_assigned = utilities.give_pdbs_to_interaction(interaction, pdbs, connection)
        if pdbs_assigned:
            pdbs_assigned_count += len(pdbs_assigned)
            interactions_assigned_count += 1
        print("(Assigned %s)" % (", ".join(pdbs_assigned) if pdbs_assigned else "none"))
    print("Assigned %i PDBs to %i interactions." % (pdbs_assigned_count, interactions_assigned_count))

if check_previous:
    print("Getting interactions that have been previously checked for PDBs...")
    checked_interactions = [
     pygtop.get_target_by_id(target_id).get_interaction_by_id(interaction_id)
      for interaction_id, target_id
       in utilities.get_interaction_ids_already_checked_for_pdbs(connection)
    ]
    checked_interactions = [
     i for i in checked_interactions if i.interaction_id not in never_checked_ids
    ]
    print("There are %i such interactions." % (len(checked_interactions)))

    if checked_interactions:
        interactions_assigned_count = 0
        pdbs_assigned_count = 0
        print("Assigning PDBs to checked interactions...")
        while checked_interactions:
            interaction = checked_interactions.pop()
            print("\tChecking %s" % str(interaction), end=" ")
            pdbs = interaction.find_all_pdbs()
            pdbs_assigned = utilities.give_pdbs_to_interaction(interaction, pdbs, connection)
            if pdbs_assigned:
                pdbs_assigned_count += len(pdbs_assigned)
                interactions_assigned_count += 1
            print("(Assigned %s)" % (", ".join(pdbs_assigned) if pdbs_assigned else "none"))
        print("Assigned %i PDBs to %i interactions." % (pdbs_assigned_count, interactions_assigned_count))



print("")
connection.close()
