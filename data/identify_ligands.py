import molecupy
import pygtop
import utilities
print("")

connection = utilities.get_connection()
try:
    print("Getting all Interaction-PDB maps in the staging database...")
    interaction_pdb_maps = utilities.get_interaction_pdb_maps(connection)
    print("There are %i Interaction-PDB maps." % len(interaction_pdb_maps))

    interaction_pdb_maps = [
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map[3]
    ]
    print("There are %i Interaction-PDB maps with no HET." % len(interaction_pdb_maps))

    print("Looking for HETs...")
    for pdb_map in interaction_pdb_maps:
        interaction = pygtop.get_target_by_id(pdb_map[0]).get_interaction_by_id(pdb_map[1])
        ligand = interaction.get_ligand()
        print("\t%i%s: Looking for %s in PDB %s..." % (
         pdb_map[1], pdb_map[2], ligand.name, pdb_map[2]
        ), end=" ")
        pdb = molecupy.get_pdb_remotely(pdb_map[2])
        molecule = ligand.find_in_pdb_by_smiles(pdb)
        if not molecule:
            molecule = ligand.find_in_pdb_by_name(pdb)
        if not molecule:
            molecule = ligand.find_in_pdb_by_mass(pdb)
        if not molecule:
            molecule = ligand.find_in_pdb_by_peptide_string(pdb)
        if molecule:
            try:
                name = molecule.molecule_id
            except:
                name = molecule.chain_id
            print(name)
            utilities.give_pdb_map_het_code(pdb_map[1], pdb_map[2], name, connection)
        else:
            print("Not found")

finally:
    connection.close()
    print("")
