import pygtop
import utilities
print("")

live_connection = utilities.get_live_connection()
stage_connection = utilities.get_connection()

try:
    pass
finally:
    print("")
    stage_connection.close()
    live_connection.close()
