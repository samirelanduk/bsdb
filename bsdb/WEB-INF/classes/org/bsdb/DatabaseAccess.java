package org.bsdb;

import java.sql.*;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

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


  public static ResultSet issueOrderedSqlQuery(
   String columns, String table, String orderBy
  ) throws SQLException {
		String query = String.format(
     "SELECT %s FROM %s ORDER BY %s;", columns, table, orderBy
    );
		ResultSet rs = issueRawSqlQuery(query);
		return rs;
	}


  public static ResultSet issueRawSqlQuery(String query) {
		Connection conn = getConnection();
		if (conn != null) {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			return rs;
		} else {
			return null;
		}
	}


  public static Object[][] getObjectGridFromResultSet(ResultSet rs) {
		int rowcount = 0;
		if (rs.last()) {
		  rowcount = rs.getRow();
		  rs.beforeFirst();
		}
		int columnCount = rs.getMetaData().getColumnCount();
		Object[][] rows = new Object[rowcount][columnCount];
		int i = 0;
		while (rs.next()) {
			Object[] values = new Object[columnCount];
			for (int c = 1; c <= columnCount; c++) {
				values[c-1] = rs.getObject(c);
			}
			rows[i] = values;
			i++;
		}
		return rows;
	}

}
