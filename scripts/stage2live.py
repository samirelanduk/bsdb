import pygtop
import utilities
import molecupy
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
    for stage_interaction_id in new_stage_interaction_ids:
        maps = [pdbmap for pdbmap in new_interaction_pdb_maps
         if pdbmap["interactionId"] == stage_interaction_id and pdbmap["contactRatio"]]
        print("\tNew interaction %i has %i usable PDB maps..." % (
         stage_interaction_id, len(maps))
        , end=" ")
        if maps:
            map_to_use = None
            correct_maps = [pdbmap for pdbmap in maps if pdbmap["manuallyMarkedCorrect"]]
            if len(correct_maps) == 0:
                map_to_use = sorted(maps, key=lambda k: k["contactRatio"])[-1]
            elif len(correct_maps) == 1:
                map_to_use = correct_maps[0]
            else:
                map_to_use = sorted(correct_maps, key=lambda k: k["contactRatio"])[-1]

            try:
                interaction = pygtop.get_target_by_id(
                 map_to_use["targetId"]).get_interaction_by_id(
                  map_to_use["interactionId"])
            except pygtop.NoSuchInteractionError:
                print("Could not retrieve interaction from web services")
            het_name = map_to_use["hetId"] if len(map_to_use["hetId"]) == 1 else molecupy.get_pdb_remotely(
             map_to_use["pdbCode"]
            ).model().get_small_molecule_by_id(map_to_use["hetId"]).molecule_name()
            utilities.make_live_sequence_from_stage_map(
             interaction,
             map_to_use,
             het_name,
             stage_connection,
             live_connection
            )
            print("Using map %i%s" % (map_to_use["interactionId"], map_to_use["pdbCode"]))
        else:
            print("")

    utilities.fill_out_other_tables(live_connection)


finally:
    print("")
    stage_connection.close()
    live_connection.close()
