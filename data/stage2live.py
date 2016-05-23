import pygtop
import utilities
print("")

live_connection = utilities.get_live_connection()
stage_connection = utilities.get_connection()

try:
    live_interaction_ids = utilities.get_live_interaction_ids(live_connection)
    print("There are %i sequences in the live database." % len(live_interaction_ids))

    interaction_pdb_maps = utilities.get_interaction_pdb_maps(stage_connection)
    stage_interaction_ids = set([pdbmap["interactionId"] for pdbmap in interaction_pdb_maps])
    print("There are %i interactions with maps in the stage database." % (
     len(stage_interaction_ids)
    ))

    new_interaction_pdb_maps = [
     i for i in interaction_pdb_maps if i["interactionId"] not in live_interaction_ids
    ]
    new_stage_interaction_ids = set([pdbmap["interactionId"] for pdbmap in new_interaction_pdb_maps])
    print("%i of these are not in the live database." % (
     len(new_stage_interaction_ids)
    ))
    print("These have %i PDB maps between them." % len(new_interaction_pdb_maps))

    print("Transferring new interactions to live database as sequences...")
    for stage_interaction_id in stage_interaction_ids:
        maps = [pdbmap for pdbmap in new_interaction_pdb_maps
         if pdbmap["interactionId"] == stage_interaction_id]
        print("\tNew interaction %i has %i PDB maps..." % (
         stage_interaction_id, len(maps))
        )


finally:
    print("")
    stage_connection.close()
    live_connection.close()
