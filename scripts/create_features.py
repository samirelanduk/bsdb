import utilities
import sys
import os
import molecupy
print("")

connection = utilities.get_live_connection()

try:
    sequence_ids = utilities.get_sequence_ids_from_table(connection)
    print("There are %i sequences in the live database." % len(sequence_ids))

    paths = utilities.get_paths("bsdb")
    matrices = os.listdir(paths["tomcat_dir"] + "static/features")
    matrix_ids = [int(f.split(".")[0]) for f in matrices if f[0] != "."]
    sequences_without_feature_viewer = [i for i in sequence_ids if i not in matrix_ids]
    print("%i of these need a feature viewer generating." % len(
     sequences_without_feature_viewer
    ))

    print("Creating feature viewers...")
    for sequence_id in sequences_without_feature_viewer:
        sequence = utilities.get_sequence_as_dict(sequence_id, connection)
        pdb = molecupy.get_pdb_remotely(sequence["pdb"])
        chain = pdb.model.get_chain_by_id(sequence["chain"])
        with open("feature.html") as f:
            feature_html = f.read() % sequence["sequence"]
        location = paths["tomcat_dir"] + "static/features/%i.html" % sequence_id
        print("\tSaving %s..." % location)
        with open(location, "w") as f:
            f.write(feature_html)

finally:
    connection.close()
    print("")
