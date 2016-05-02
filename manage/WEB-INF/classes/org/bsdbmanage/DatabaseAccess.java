package org.bsdbmanage;

import java.sql.*;
import java.util.Date;
import java.util.ArrayList;
import java.io.*;

public class DatabaseAccess {

	//Returns a connection to the bsdb_stage database
	public static Connection getConnection() {
		try {
	    Class.forName("org.postgresql.Driver");
	    Connection connection;
	    String url = String.format("jdbc:postgresql://%s/%s", Config.host, Config.db);
	    String user = Config.user;
	    String password = Config.password;

	    connection = DriverManager.getConnection(url, user, password);
	    return connection;
		}	catch (SQLException e) {
			return null;
 		} catch (ClassNotFoundException e) {
			return null;
 		}
	}


	//Issues an SQL query to the database and returns the resulting ResultSet
  public static ResultSet issuePreparedSqlQuery(String query, Object... params) {
		Connection conn = getConnection();
		if (conn != null) {
			try {
				PreparedStatement st = conn.prepareStatement(query);
				for (int i = 0; i < params.length; i++) {
					st.setObject(i + 1, params[i]);
				}
				ResultSet rs = st.executeQuery();
				conn.close();
				return rs;
			} catch (SQLException e) {
				return null;
			}
		} else {
			return null;
		}
	}


	//Takes a ResultSet returned by an SQL query and turns it into an Object array
  public static Object[][] getObjectGridFromResultSet(ResultSet rs) {
		try {
			int columnCount = rs.getMetaData().getColumnCount();
			ArrayList<Object[]> rows = new ArrayList<Object[]>();
			int i = 0;
			while (rs.next()) {
				Object[] values = new Object[columnCount];
				for (int c = 1; c <= columnCount; c++) {
					values[c-1] = rs.getObject(c);
				}
				rows.add(values);
				i++;
			}
	    Object[][] objArray = new Object[rows.size()][columnCount];
	    objArray = rows.toArray(objArray);
			return objArray;
		} catch (SQLException e) {
			return null;
		}
	}


	//Gets all interactions in the staging database
  public static Interaction[] getAllInteractions() {
  	ArrayList<Interaction> interactions = new ArrayList<Interaction>();
    ResultSet rs = issuePreparedSqlQuery("SELECT * FROM interactions ORDER BY interactionId;");
		if (rs != null) {
	    Object[][] rows = getObjectGridFromResultSet(rs);
	    for (Object[] row : rows) {
	      interactions.add(new Interaction(row));
	    }
	    Interaction[] interactionsArray = new Interaction[interactions.size()];
	    interactionsArray = interactions.toArray(interactionsArray);
	    return interactionsArray;
		} else {
			return null;
		}
  }


	//Gets a single Interaction object by ID
	public static Interaction getInteraction(int interactionId) {
		ResultSet rs = issuePreparedSqlQuery(
		 "SELECT * FROM interactions WHERE interactionId=?",
		 interactionId
		);
		if (rs != null) {
				Object[][] rows = getObjectGridFromResultSet(rs);
				return new Interaction(rows[0]);
		} else {
			return null;
		}
	}


	//Gets all PDB codes belonging to a given Interaction (by interactionId)
	public static ArrayList<InteractionPdb> getPdbMapsOfInteraction(int interactionId) {
		ArrayList<InteractionPdb> pdbMaps = new ArrayList<InteractionPdb>();
		ResultSet rs = issuePreparedSqlQuery(
		 "SELECT * FROM interaction_pdbs WHERE interactionId=?",
		 interactionId
		);
		Object[][] rows = getObjectGridFromResultSet(rs);
		for (Object[] row : rows) {
      pdbMaps.add(new InteractionPdb(row));
    }
		return pdbMaps;
	}


	//Gets a single Interaction object by ID
	public static InteractionPdb getInteractionPdb(String mapId) {
		ResultSet rs = issuePreparedSqlQuery(
		 "SELECT * FROM interaction_pdbs WHERE mapId=?",
		 mapId
		);
		if (rs != null) {
				try {
					Object[][] rows = getObjectGridFromResultSet(rs);
					return new InteractionPdb(rows[0]);
				} catch (ArrayIndexOutOfBoundsException e) {
					return null;
				}
		} else {
			return null;
		}
	}


	//Flips the manualCorrectMark value of a given InteractionPdb
	public static void toggleInteractionPdbManualCorrectnessMark(String mapId) {
		issuePreparedSqlQuery(
		 "UPDATE interaction_pdbs SET manualCorrectMapMark = NOT manualCorrectMapMark WHERE mapId=?",
		 mapId
		);
	}


	//Manually adds an Interaction-PDB map
	public static void addInteractionPdb(int interactionId, String pdbCode) {
		ResultSet rs = issuePreparedSqlQuery("SELECT mapId FROM interaction_pdbs");
		ArrayList<String> existingIds = new ArrayList<String>();
		for (Object[] row : getObjectGridFromResultSet(rs)) {
			existingIds.add((String)row[0]);
		}
		if (!(existingIds.contains(String.format("%d%s", interactionId, pdbCode)))) {
			issuePreparedSqlQuery(
			 "INSERT INTO interaction_pdbs VALUES (?, ?, ?, true, true)",
			 String.format("%d%s", interactionId, pdbCode),
			 interactionId,
			 pdbCode
			);
		}
	}


	//Deletes an InteractionPdb
	public static void removeInteractionPdb(int interactionId, String pdbCode) {
		issuePreparedSqlQuery(
		 "DELETE FROM interaction_pdbs WHERE mapId=?",
		 String.format("%d%s", interactionId, pdbCode)
		);
	}


	//Blacklists an InteractionPdb
	public static void blacklistMap(int interactionId, String pdbCode) {
		ResultSet rs = issuePreparedSqlQuery("SELECT mapId FROM false_interaction_pdbs");
		ArrayList<String> existingIds = new ArrayList<String>();
		for (Object[] row : getObjectGridFromResultSet(rs)) {
			existingIds.add((String)row[0]);
		}
		if (!(existingIds.contains(String.format("%d%s", interactionId, pdbCode)))) {
			issuePreparedSqlQuery(
			 "INSERT INTO false_interaction_pdbs VALUES (?, ?, ?)",
			 String.format("%d%s", interactionId, pdbCode),
			 interactionId,
			 pdbCode
			);
		}
	}

}
