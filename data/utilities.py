import psycopg2
import datetime
import config

def get_connection():
    conn = psycopg2.connect(
     host=config.host,
     database=config.db,
     user=config.user,
     password=config.password
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

    cursor.execute(
     """INSERT INTO interactions VALUES (
      %(interactionId)s,
      %(ligandId)s,
      %(targetId)s,
      %(species)s,
      %(type)s,
      %(action)s,
      %(affinityType)s,
      %(affinityValue)s,
      %(affinityRange)s,
      %(ligandIsPeptide)s,
      %(dateAdded)s,
      %(dateModified)s
      );""", dictionary
    )
    connection.commit()
    cursor.close()


def interaction_differs_from_table(interaction, connection):
    interaction_object_dict = interaction_object_to_dict(interaction)
    interaction_row_dict = get_table_interaction_as_dict(interaction, connection)
    return interaction_object_dict != interaction_row_dict


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
