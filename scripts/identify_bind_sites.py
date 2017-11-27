import molecupy
from molecupy.structures import ResiduicStructure
import utilities
import warnings
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
        warnings.simplefilter("ignore")
        try:
            pdb = molecupy.get_pdb_remotely(pdb_map["pdbCode"])
            ligand_is_peptide = len(pdb_map["hetId"]) == 1
            ligand_is_antibody = "," in pdb_map["hetId"]
            ligand = None
            if ligand_is_peptide:
                ligand = pdb.model().get_chain_by_id(pdb_map["hetId"])
            elif ligand_is_antibody:
                chains = [pdb.model().get_chain_by_id(id_) for id_ in pdb_map["hetId"].split(",")]
                residues = []
                for chain in chains:
                    residues += chain.residues()
                ligand = ResiduicStructure(*residues)
            else:
                ligand = pdb.model().get_small_molecule_by_id(pdb_map["hetId"])
            print("\t%i%s: Looking for %s's binding site in PDB %s..." % (
             pdb_map["interactionId"], pdb_map["pdbCode"], ligand, pdb_map["pdbCode"]
            ), end=" ")
            if ligand:
                site = ligand.bind_site() if not ligand_is_peptide and not ligand_is_antibody else None
                calculation_required = False
                if not site:
                    calculation_required = True
                    site = ligand.predict_bind_site()
                if site:
                    utilities.give_pdb_map_bind_site(
                     pdb_map["interactionId"], pdb_map["pdbCode"], site, connection
                    )
                    print("Found %i residues via %s." % (
                     len(site.residues()),
                     "calculation" if calculation_required else "mapping"
                     )
                    )
                else:
                    print("Not found")
            else:
                print("Not found")
        except molecupy.InvalidPdbCodeError:
            print("\t%s not found" % pdb_map["pdbCode"])
        except Exception as e:
            print("\t%s encountered a problem (%s)" % (pdb_map["pdbCode"], repr(e)))
finally:
    connection.close()
    print("")
