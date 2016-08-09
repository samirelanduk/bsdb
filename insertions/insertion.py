import molecupy
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
    print("%s doesn't seem to be a valid chain in PDB %s\n" % (sys.argv[2], pdb.pdb_code()))
    sys.exit()
print("")
