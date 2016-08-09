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



print("")
