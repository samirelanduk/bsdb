package org.bsdb;

import java.sql.*;
import java.util.ArrayList;

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

	// Gets HTML rows for each ligand
	public static String[] getLigandRows() {
		ResultSet rs = issuePreparedSqlQuery(
		 "SELECT name, ligandId, approved, type, mass, synonyms FROM ligands"
		);
		if (rs != null) {
			Object[][] sqlRows = getObjectGridFromResultSet(rs);
			String[] tableRows = new String[sqlRows.length];
			for (int i = 0; i < sqlRows.length; i++) {
				Object[] row = sqlRows[i];
				int id = (Integer)row[1];
				String hyperlink = String.format("/ligands/detail.jsp?id=%d", id);
				String approved = (Boolean)row[2] ? "Yes" : "No";
				String synonyms = ((String)row[5]).replace("#", ", ");
				String cells = String.format(
				 "%s%s%s%s%s%s",
				 Utilities.enclose(
				  "td",
					String.format("value='%s'", row[0]),
					Utilities.enclose("a", String.format("href='%s'", hyperlink), (String)row[0])
				 ),
				 Utilities.enclose(
				  "td",
					String.format("value='%d'", id),
					"" + id
				 ),
				 Utilities.enclose(
				  "td",
					String.format("value='%s'", approved),
					approved
				 ),
				 Utilities.enclose(
				  "td",
					String.format("value='%s'", (String)row[3]),
					(String)row[3]
				 ),
				 Utilities.enclose(
				  "td",
					String.format("value='%f'", (Float)row[4]),
					String.format("%f", (Float)row[4])
				 ),
				 Utilities.enclose("td", "", synonyms)
				);
				tableRows[i] = Utilities.enclose("tr", "", cells);
			}
			return tableRows;
		} else {
			return null;
		}
	}
}
