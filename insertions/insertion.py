import molecupy
from molecupy.structures import ResiduicSequence
import sys
print("")

# Get PDB
pdb = None
try:
    code = sys.argv[1]
    pdb = molecupy.get_pdb_remotely(code)
except IndexError:
    print("Please provide a PDB code.\n")
    sys.exit()
except molecupy.InvalidPdbCodeError:
    print("%s doesn't seem to be a valid PDB code.\n" % sys.argv[1])
    sys.exit()

# Get chain
chain = None
try:
    chain = sys.argv[2]
    chain = pdb.model().get_chain_by_id(chain)
except IndexError:
    print("Please provide a chain ID.\n")
    sys.exit()
if chain is None:
    print("%s doesn't seem to be a valid chain in PDB %s\n" % (
     sys.argv[2], pdb.pdb_code())
    )
    sys.exit()

# Report information
print("Identified chain %s in PDB %s." % (chain.chain_id(), pdb.pdb_code()))
print("It has %i residues." % len(chain.residues()))
print("%i of these are missing from the PDB structure." % (
 len(chain.residues()) - len(chain.residues(include_missing=False)))
)

# Secondary structure information
helices = [{
 "x": chain.residues().index(helix.residues()[0]) + 1,
 "y": chain.residues().index(helix.residues()[-1]) + 1
} for helix in chain.alpha_helices()]
strands = [{
 "x": chain.residues().index(strand.residues()[0]) + 1,
 "y": chain.residues().index(strand.residues()[-1]) + 1
} for strand in chain.beta_strands()]

# Go through each possible cut
data = []
for index, residue in enumerate(chain.residues()[:-1]):
    next_residue = chain.residues()[index + 1]
    sequence1 = ResiduicSequence(*chain.residues()[:index + 1])
    sequence2 = ResiduicSequence(*chain.residues()[index:])
    usable1 = len(sequence1.residues(include_missing=False)) / len(sequence1.residues()) >= 0.5
    usable2 = len(sequence2.residues(include_missing=False)) / len(sequence2.residues()) >= 0.5
    if usable1 and usable2:
        internal1 = len(sequence1.internal_contacts())
        external = len(sequence1.contacts_with(sequence2))
        internal2 = len(sequence2.internal_contacts())
        print("\t%i: %s-%s (%.1f/%.1f %.1f)" % (
         index + 1,
         residue.residue_name(),
         next_residue.residue_name(),
         internal1/external,
         internal2/external,
         (internal1/external) + (internal2/external)
        ))
        data.append({"x": index + 1, "y": (internal1/external) + (internal2/external)})

feature = ""
with open("insertions/feature.html") as f:
    feature = f.read() % (chain.sequence_string(), str(helices), str(strands), str(data))
with open("output.html", "w") as f:
    f.write(feature)
print("")
