import utilities
import sys
import os
import requests
print("")

connection = utilities.get_live_connection()

try:
    sequence_ids = utilities.get_sequence_ids_from_table(connection)
    print("There are %i sequences in the live database." % len(sequence_ids))

    paths = utilities.get_paths("bsdb")
    pdbs = os.listdir(paths["tomcat_dir"] + "static/pdbs")
    pdb_ids = [int(f.split(".")[0]) for f in pdbs if f[0] != "."]
    sequences_without_pdb= [i for i in sequence_ids if i not in pdb_ids]
    print("%i of these need a PDB file generating." % len(
     sequences_without_pdb
    ))

    print("Creating PDB files...")
    for sequence_id in sequences_without_pdb:
        sequence = utilities.get_sequence_as_dict(sequence_id, connection)
        pdb = requests.get("http://files.rcsb.org/view/%s.pdb" % sequence["pdb"]).text
        location = paths["tomcat_dir"] + "static/pdbs/%i.pdb" % (sequence_id)
        print("\tSaving %s..." % location)
        with open(location, "w") as f:
            f.write(pdb)

finally:
    connection.close()
    print("")
