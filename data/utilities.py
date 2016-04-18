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


def add_interaction_to_table(interaction, connection):
    cursor = connection.cursor()
    affinity_range = str(interaction.affinity_range[0]
     ) if len(interaction.affinity_range) == 1 else " - ".join(
      [str(val) for val in interaction.affinity_range])
    now = datetime.datetime.now()

    cursor.execute(
     """INSERT INTO interactions VALUES (
      %(interactionId)s,
      %(ligandId)s,
      %(targetId)s,
      %(species)s,
      %(type)s,
      %(action)s,
      %(affinityValue)s,
      %(affinityRange)s,
      %(ligandIsPeptide)s,
      %(dateAdded)s,
      %(dateModified)s
      );""", {
       "interactionId": interaction.interaction_id,
       "ligandId": interaction._ligand_id,
       "targetId": interaction._target_id,
       "species": interaction.species,
       "type": interaction.type,
       "action": interaction.action,
       "affinityValue": interaction.affinity_value,
       "affinityRange":affinity_range,
       "ligandIsPeptide": "peptide" in interaction.get_ligand().ligand_type.lower(),
       "dateAdded": now,
       "dateModified": now
      }
    )
    connection.commit()
