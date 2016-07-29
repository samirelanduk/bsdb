import utilities
import sys
import os
import re
import molecupy
print("")

connection = utilities.get_live_connection()

try:
    sequence_ids = utilities.get_sequence_ids_from_table(connection)
    print("There are %i sequences in the live database." % len(sequence_ids))

    paths = utilities.get_paths("bsdb")
    features = os.listdir(paths["tomcat_dir"] + "static/features")
    feature_ids = [int(f.split(".")[0]) for f in features if f[0] != "."]
    sequences_without_feature_viewer = [i for i in sequence_ids if i not in feature_ids]
    print("%i of these need a feature viewer generating." % len(
     sequences_without_feature_viewer
    ))

    print("Creating feature viewers...")
    for sequence_id in sequences_without_feature_viewer:
        sequence = utilities.get_sequence_as_dict(sequence_id, connection)
        pdb = molecupy.get_pdb_remotely(sequence["pdb"])
        chain = pdb.model().get_chain_by_id(sequence["chain"])
        sequence_start = re.search("[A-Z]", sequence["sequence"]).start()
        sequence_end = len(sequence["sequence"]) - re.search("[A-Z]", sequence["sequence"][::-1]).start()
        bind_sequence = sequence["sequence"][sequence_start:sequence_end]

        helices = []
        for helix in sorted(chain.alpha_helices(), key=lambda k: k.helix_id()):
            try:
                helix_start = sequence["residueIds"].index(helix.residues()[0].residue_id())
            except ValueError:
                helix_start = -1
            try:
                helix_end = sequence["residueIds"].index(helix.residues()[-1].residue_id())
            except ValueError:
                helix_end = -1
            if helix_start != -1 and helix_end != -1:
                helices.append({"x": helix_start + 1, "y": helix_end + 1})
            elif helix_start != -1 and helix_end == -1:
                helices.append({"x": helix_start + 1, "y": len(bind_sequence)})
            elif helix_start == -1 and helix_end != -1:
                helices.append({"x": 0, "y": helix_end + 1})
        helices = sorted(helices, key=lambda k: k["x"])
        for index, helix in enumerate(helices[:-1]):
            if helices[index + 1]["x"] - helix["y"] <= 1:
                helices[index + 1]["x"] = helix["x"]
                helix["x"] = helix["y"] = -1
        helices = [h for h in helices if h["x"] != -1]

        strands = []
        for strand in sorted(chain.beta_strands(), key=lambda k: k.strand_id()):
            try:
                strand_start = sequence["residueIds"].index(strand.residues()[0].residue_id())
            except ValueError:
                strand_start = -1
            try:
                strand_end = sequence["residueIds"].index(strand.residues()[-1].residue_id())
            except ValueError:
                strand_end = -1
            if strand_start != -1 and strand_end != -1:
                strands.append({"x": strand_start + 1, "y": strand_end + 1})
            elif strand_start != -1 and strand_end == -1:
                strands.append({"x": strand_start + 1, "y": len(bind_sequence)})
            elif strand_start == -1 and strand_end != -1:
                strands.append({"x": 0, "y": strand_end + 1})
        strands = sorted(strands, key=lambda k: k["x"])
        for index, strand in enumerate(strands[:-1]):
            if strands[index + 1]["x"] - strand["y"] <= 1:
                strands[index + 1]["x"] = strand["x"]
                strand["x"] = strand["y"] = -1
        strands = [s for s in strands if s["x"] != -1]

        with open("feature.html") as f:
            feature_html = f.read() % (
             bind_sequence,
             str(helices),
             str(strands)
            )
        location = paths["tomcat_dir"] + "static/features/%i.html" % (sequence_id)
        print("\tSaving %s..." % location)
        with open(location, "w") as f:
            f.write(feature_html)

finally:
    connection.close()
    print("")
