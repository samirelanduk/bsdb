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
  public static ResultSet issueRawSqlQuery(String query) {
		Connection conn = getConnection();
		if (conn != null) {
			try {
				Statement st = conn.createStatement();
				ResultSet rs = st.executeQuery(query);
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
    ResultSet rs = issueRawSqlQuery("SELECT * FROM interactions ORDER BY interactionId;");
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


	public static ArrayList<String> getPdbsOfInteraction(int interactionId) {
		ArrayList<String> pdbs = new ArrayList<String>();
		ResultSet rs = issueRawSqlQuery(String.format(
		 "SELECT pdbCode FROM interaction_pdbs WHERE interactionId=%d", interactionId
		));
		Object[][] rows = getObjectGridFromResultSet(rs);
		for (Object[] row : rows) {
      pdbs.add((String)row[0]);
    }

		return pdbs;
	}



}
