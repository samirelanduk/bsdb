import pg8000
import datetime
import config
import math
import pygtop

def get_connection():
    conn = pg8000.connect(
     host=config.host,
     database=config.db,
     user=config.user,
     password=config.password
    )
    return conn


def get_live_connection():
    conn = pg8000.connect(
     host=config.livehost,
     database=config.livedb,
     user=config.liveuser,
     password=config.livepassword
    )
    return conn


def get_interactions_row_count(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT COUNT(*) FROM interactions;")
    rowcount = cursor.fetchone()[0]
    cursor.close()
    return rowcount


def get_interaction_ids_from_table(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT interactionId FROM interactions;")
    ids = [row[0] for row in cursor.fetchall()]
    cursor.close()
    return ids


def affinity_range_to_str(range_tuple):
    return str(range_tuple[0]) if len(range_tuple) == 1 else " - ".join(
     [str(val) for val in range_tuple]
    )


def interaction_object_to_dict(interaction):
    return {
     "interactionId": interaction.interaction_id,
     "ligandId": interaction._ligand_id,
     "targetId": interaction._target_id,
     "species": interaction.species,
     "type": interaction.type,
     "action": interaction.action,
     "affinityType": interaction.affinity_type,
     "affinityValue": interaction.affinity_value,
     "affinityRange": affinity_range_to_str(interaction.affinity_range),
     "ligandIsPeptide": "peptide" in interaction.get_ligand().ligand_type.lower()
    }


def get_table_interaction_as_dict(interaction, connection):
    cursor = connection.cursor()
    cursor.execute(
     "SELECT * FROM interactions WHERE interactionId=%s",
     (interaction.interaction_id,)
    )
    row = cursor.fetchone()
    dictionary = {
     "interactionId": row[0],
     "ligandId": row[1],
     "targetId": row[2],
     "species": row[3],
     "type": row[4],
     "action": row[5],
     "affinityType": row[6],
     "affinityValue": row[7],
     "affinityRange": row[8],
     "ligandIsPeptide": row[9]
    }
    cursor.close()
    return dictionary


def add_interaction_to_table(interaction, connection):
    cursor = connection.cursor()
    now = datetime.datetime.now()
    dictionary = interaction_object_to_dict(interaction)
    dictionary["dateAdded"] = now
    dictionary["dateModified"] = now

    values = [dictionary[key] for key in [
     "interactionId",
     "ligandId",
     "targetId",
     "species",
     "type",
     "action",
     "affinityType",
     "affinityValue",
     "affinityRange",
     "ligandIsPeptide",
     "dateAdded",
     "dateModified"
    ]]

    cursor.execute(
     """INSERT INTO interactions VALUES (
      %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
      );""", values
    )
    connection.commit()
    cursor.close()


def interaction_differs_from_table(interaction, connection):
    interaction_object_dict = interaction_object_to_dict(interaction)
    interaction_row_dict = get_table_interaction_as_dict(interaction, connection)
    for key in interaction_object_dict:
        if type(interaction_object_dict[key]) is float:
            if math.floor(interaction_object_dict[key]) != math.floor(interaction_row_dict[key]):
                return True
        else:
            if interaction_object_dict[key] != interaction_row_dict[key]:
                return True
    return False


def update_interaction(interaction, connection):
    now = datetime.datetime.now()
    dictionary = interaction_object_to_dict(interaction)
    dictionary["dateModified"] = now

    cursor = connection.cursor()
    cursor.execute(
     """UPDATE interactions SET
      ligandId = '%(ligandId)s',
      targetId = '%(targetId)s',
      species = '%(species)s',
      type = '%(type)s',
      action = '%(action)s',
      affinityType = '%(affinityType)s',
      affinityValue = '%(affinityValue)s',
      affinityRange = '%(affinityRange)s',
      ligandIsPeptide = '%(ligandIsPeptide)s',
      dateModified = '%(dateModified)s' WHERE interactionId=%(interactionId)s;""" % dictionary
    )
    connection.commit()
    cursor.close()


def remove_interaction_row_by_id(interaction_id, connection):
    cursor = connection.cursor()
    cursor.execute("DELETE FROM interactions WHERE interactionId='%s'", (interaction_id,))
    connection.commit()
    cursor.close()


def get_interaction_ids_never_checked_for_pdbs(connection):
    cursor = connection.cursor()
    cursor.execute(
     "SELECT interactionId, targetId FROM interactions WHERE dateLastCheckedForPdbs IS null;"
    )
    id_pairs = [(row[0], row[1]) for row in cursor.fetchall()]
    cursor.close()
    return id_pairs


def get_interaction_ids_already_checked_for_pdbs(connection):
    cursor = connection.cursor()
    cursor.execute(
     "SELECT interactionId, targetId FROM interactions WHERE dateLastCheckedForPdbs IS NOT null ORDER BY dateLastCheckedForPdbs;"
    )
    id_pairs = [(row[0], row[1]) for row in cursor.fetchall()]
    cursor.close()
    return id_pairs


def give_pdbs_to_interaction(interaction, pdbs, connection):
    now = datetime.datetime.now()
    cursor = connection.cursor()
    cursor.execute(
     "UPDATE interactions SET dateLastCheckedForPdbs=%s WHERE interactionId=%s;",
     (now, interaction.interaction_id)
    )
    connection.commit()
    cursor.execute(
     "SELECT pdbCode FROM interaction_pdbs WHERE interactionId=%s",
     (interaction.interaction_id,)
    )
    pdbs_already_assigned = [row[0] for row in cursor.fetchall()]
    cursor.execute(
     "SELECT pdbCode FROM false_interaction_pdbs WHERE interactionId=%s",
     (interaction.interaction_id,)
    )
    blacklisted_pdbs = [row[0] for row in cursor.fetchall()]

    pdbs_assigned_now = []
    for pdb in pdbs:
        if pdb not in pdbs_already_assigned and pdb not in blacklisted_pdbs:
            pdbs_assigned_now.append(pdb)
            cursor.execute(
             "INSERT INTO interaction_pdbs VALUES (%s, %s, %s, false, false);",
             (str(interaction.interaction_id) + pdb, interaction.interaction_id, pdb)
            )
            connection.commit()
    cursor.close()
    return pdbs_assigned_now


def get_interaction_pdb_maps(connection):
    cursor = connection.cursor()
    cursor.execute(
     """
     SELECT
      interactions.targetId, interaction_pdbs.interactionId, interaction_pdbs.pdbCode,
      interaction_pdbs.het, interaction_pdbs.bindingResidues, interaction_pdbs.bindSequence,
      interaction_pdbs.manualCorrectMapMark, interaction_pdbs.receptorChain, interaction_pdbs.originalChainLength,
      interaction_pdbs.proportionalLength, interaction_pdbs.internalContacts,
      interaction_pdbs.externalContacts, interaction_pdbs.contactRatio
     FROM interaction_pdbs LEFT JOIN interactions ON
      interaction_pdbs.interactionId = interactions.interactionId;"""
    )
    interaction_pdb_maps = [{
     "targetId": row[0],
     "interactionId": row[1],
     "pdbCode": row[2],
     "het": row[3],
     "bindingResidues": row[4],
     "bindSequence": row[5],
     "manuallyMarkedCorrect": row[6],
     "receptorChain": row[7],
     "originalChainLength": row[8],
     "proportionalLength": row[9],
     "internalContacts": row[10],
     "externalContacts": row[11],
     "contactRatio": row[12]
    } for row in cursor.fetchall()]

    cursor.close()
    return interaction_pdb_maps


def give_pdb_map_het_code(interaction_id, pdb_code, het_code, connection):
    cursor = connection.cursor()
    cursor.execute(
     "UPDATE interaction_pdbs SET het=%s WHERE mapId=%s;",
     (het_code, str(interaction_id) + pdb_code)
    )
    connection.commit()
    cursor.close()


def give_pdb_map_bind_site(interaction_id, pdb_code, site, connection):
    cursor = connection.cursor()
    cursor.execute(
     "UPDATE interaction_pdbs SET bindingResidues=%s WHERE mapId=%s;", (
      ", ".join([residue.residue_id for residue in site.residues]),
      str(interaction_id) + pdb_code
     )
    )
    connection.commit()
    cursor.close()


def give_pdb_map_bind_sequence(interaction_id, pdb_code, sequence, chain_id,
 chain_length, proportional_length, internal_contacts, external_contacts,
 contact_ratio, connection):
    cursor = connection.cursor()
    cursor.execute(
     """UPDATE interaction_pdbs SET
      bindSequence=%s,
      receptorChain=%s,
      originalChainLength=%s,
      proportionalLength=%s,
      internalContacts=%s,
      externalContacts=%s,
      contactRatio=%s
      WHERE mapId=%s;""", (
      sequence,
      chain_id,
      chain_length,
      proportional_length,
      internal_contacts,
      external_contacts,
      contact_ratio,
      str(interaction_id) + pdb_code
     )
    )
    connection.commit()
    cursor.close()


def get_live_interaction_ids(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT sequenceId FROM sequences;")
    ids = [row[0] for row in cursor.fetchall()]
    cursor.close()
    return ids


def make_live_sequence_from_stage_map(interaction, pdb_map, stage_connection, live_connection):
    interaction_dict = interaction_object_to_dict(interaction)
    cursor = live_connection.cursor()
    cursor.execute("""
     INSERT INTO sequences VALUES (
      %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
     );""", [
      pdb_map["interactionId"],
      interaction_dict["ligandId"],
      interaction_dict["targetId"],
      interaction_dict["species"],
      interaction_dict["action"],
      interaction_dict["affinityValue"],
      interaction_dict["affinityRange"],
      interaction_dict["affinityType"],
      pdb_map["het"],
      pdb_map["bindingResidues"],
      pdb_map["receptorChain"],
      pdb_map["originalChainLength"],
      pdb_map["bindSequence"],
      pdb_map["proportionalLength"],
      pdb_map["internalContacts"],
      pdb_map["externalContacts"],
      pdb_map["contactRatio"]
     ])
    live_connection.commit()
    cursor.close()


def fill_out_other_tables(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT sequenceId, ligandId, targetId FROM sequences;")
    sequences = cursor.fetchall()
    print("Adding any ligands that might be needed...")
    for sequence in sequences:
        cursor.execute("SELECT ligandId FROM ligands WHERE ligandId=%s;", (sequence[1],))
        if len(cursor.fetchall()) == 0:
            ligand = pygtop.get_ligand_by_id(sequence[1])
            ligand.request_molecular_properties()
            ligand.request_structural_properties()
            ligand.request_synonym_properties()
            cursor.execute("""
             INSERT INTO ligands VALUES (
              %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
             );""", [
              ligand.ligand_id,
              ligand.name,
              ligand.ligand_type,
              ligand.radioactive,
              ligand.approved,
              ligand.approval_source,
              ligand.hydrogen_bond_acceptors,
              ligand.hydrogen_bond_donors,
              ligand.rotatable_bonds,
              ligand.topological_polar_surface_area,
              ligand.molecular_weight,
              ligand.log_p,
              ligand.lipinksi_rules_broken,
              "#".join(ligand.synonyms).replace("{", "#").replace("}", "$").replace("'", "''").replace(u'\u2010', "-")
             ])
            print("\tAdded %s" % str(ligand))
            connection.commit()

    print("Adding any targets that might be needed...")
    for sequence in sequences:
        cursor.execute("SELECT targetId FROM targets WHERE targetId=%s;", (sequence[2],))
        if len(cursor.fetchall()) == 0:
            target = pygtop.get_target_by_id(sequence[2])
            cursor.execute("""
             INSERT INTO targets VALUES (
              %s, %s, %s
             );""", [
              target.target_id,
              target.name,
              target.target_type,
             ])
            print("\tAdded %s" % str(target))
            connection.commit()

    cursor.execute("SELECT ligandId FROM ligands;")
    ligands = cursor.fetchall()
    print("Adding any database links that might be needed...")
    for ligand_row in ligands:
        ligand = pygtop.get_ligand_by_id(ligand_row[0])
        cursor.execute("SELECT accession FROM ligandLinks WHERE ligandId=%s", (ligand.ligand_id,))
        accessions = [row[0] for row in cursor.fetchall()]
        ligand.request_database_properties()
        for db_link in ligand.database_links:
            if db_link.accession not in accessions:
                cursor.execute("""
                 INSERT INTO ligandLinks VALUES (
                  %s, %s, %s, %s
                 );""", [
                  db_link.accession,
                  db_link.database,
                  db_link.url,
                  ligand.ligand_id
                 ])
                connection.commit()
                print("\tAdded %s" % str(db_link))
