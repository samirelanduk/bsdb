package org.bsdbmanage;

import java.sql.*;
import java.util.Date;
import java.util.ArrayList;
import java.io.*;

public class DatabaseAccess {

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
    Class.forName("org.postgresql.Driver");
    Connection connection;
    String url = String.format("jdbc:postgresql://%s/%s", Config.host, Config.db);
    String user = Config.user;
    String password = Config.password;

    connection = DriverManager.getConnection(url, user, password);
    return connection;
	}


  public static ResultSet issueRawSqlQuery(String query) throws SQLException, ClassNotFoundException {
		Connection conn = getConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(query);
		return rs;
	}

  public static Object[][] getObjectGridFromResultSet(ResultSet rs) throws SQLException {
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
	}

  public static Interaction[] getAllInteractions() {
    ArrayList<Interaction> interactions = new ArrayList<Interaction>();
    try {
      ResultSet rs = issueRawSqlQuery("SELECT * FROM interactions;");
      Object[][] rows = getObjectGridFromResultSet(rs);

      for (Object[] row : rows) {
        interactions.add(new Interaction(row));
      }
    } catch (SQLException e) {
      StringWriter sw = new StringWriter();
      PrintWriter pw = new PrintWriter(sw);
      e.printStackTrace(pw);
      Object[] row = {0, 0, 0, sw.toString(), "", "", "", 0.0, "", false, new Date(), new Date(), new Date()};
      interactions.add(new Interaction(row));
    } catch (ClassNotFoundException e) {
      StringWriter sw = new StringWriter();
      PrintWriter pw = new PrintWriter(sw);
      e.printStackTrace(pw);
      Object[] row = {0, 0, 0, sw.toString(), "", "", "", 0.0, "", false, new Date(), new Date(), new Date()};
      interactions.add(new Interaction(row));
    }
    Interaction[] interactionsArray = new Interaction[interactions.size()];
    interactionsArray = interactions.toArray(interactionsArray);
    return interactionsArray;
  }



}
