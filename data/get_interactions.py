import pygtop

print("Obtaining ligands from GtoP...")
ligands = pygtop.get_all_ligands()

print("Obtaining interactions from GtoP...")
interactions = []
for ligand in ligands:
    interactions += ligand.get_interactions()
print("There are %i interactions." % len(interactions))
