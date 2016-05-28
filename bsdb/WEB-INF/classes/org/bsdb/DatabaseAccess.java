package org.bsdb;

import java.sql.*;

public class DatabaseAccess {

	//Returns a connection to the live database
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

}
