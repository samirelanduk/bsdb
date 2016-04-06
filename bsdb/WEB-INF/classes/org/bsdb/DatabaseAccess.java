package org.bsdb;

import java.sql.*;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class DatabaseAccess {

	public static Connection getConnection() throws SQLException {
		MysqlDataSource dataSource = new MysqlDataSource();
		dataSource.setUser(Config.user);
		dataSource.setPassword(Config.password);
		dataSource.setServerName(Config.hostname);
		dataSource.setDatabaseName(Config.db);
		Connection conn = dataSource.getConnection();
		return conn;
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


  public static ResultSet issueRawSqlQuery(String query) throws SQLException {
		Connection conn = getConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(query);
		return rs;
	}


  public static Object[][] getObjectGridFromResultSet(ResultSet rs) throws SQLException {
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
