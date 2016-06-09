import utilities
import sys
import os
print("")

connection = utilities.get_live_connection()

try:
    sequence_ids = utilities.get_sequence_ids_from_table(connection)
    print("There are %i sequences in the live database." % len(sequence_ids))

    paths = utilities.get_paths("bsdb")
    matrices = os.listdir(paths["tomcat_dir"] + "/static/matrices")
    matrix_ids = [int(f.split(".")[0]) for f in matrices if f[0] != "."]
    sequences_without_matrix = [i for i in sequence_ids if i not in matrix_ids]
    print("%i of these need a matrix generating." % len(sequences_without_matrix))
finally:
    connection.close()
    print("")
