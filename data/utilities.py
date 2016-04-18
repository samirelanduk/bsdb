import psycopg2
import config

def get_connection():
    conn = psycopg2.connect(
     host=config.host,
     database=config.db,
     user=config.user,
     password=config.password
    )
    return conn
