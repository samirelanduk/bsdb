import molecupy
import utilities
print("")

connection = utilities.get_connection()
try:
    print("Getting all Interaction-PDB maps in the staging database...")
    interaction_pdb_maps = utilities.get_interaction_pdb_maps(connection)
    print("There are %i Interaction-PDB maps." % len(interaction_pdb_maps))

    interaction_pdb_maps = [
     pdb_map for pdb_map in interaction_pdb_maps if not pdb_map["bindingResidues"]
    ]
    print("There are %i Interaction-PDB maps with no binding site." % len(
     interaction_pdb_maps
    ))

    print("Looking for binding sites...")
    for pdb_map in interaction_pdb_maps:
        pdb = molecupy.get_pdb_remotely(pdb_map["pdbCode"])
        ligand = pdb.model.get_small_molecule_by_id(pdb_map["hetId"])
        print("\t%i%s: Looking for %s's binding site in PDB %s..." % (
         pdb_map["interactionId"], pdb_map["pdbCode"], ligand, pdb_map["pdbCode"]
        ), end=" ")
        if ligand:
            site = ligand.get_binding_site()
            if not site:
                site = ligand.calculate_binding_site()
            if site:
                utilities.give_pdb_map_bind_site(
                 pdb_map["interactionId"], pdb_map["pdbCode"], site, connection
                )
                print("Found %i residues." % len(site.residues))
            else:
                print("Not found")
        else:
            print("Not found")
finally:
    connection.close()
    print("")
