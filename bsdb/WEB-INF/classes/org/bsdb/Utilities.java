package org.bsdb;

import java.sql.*;

public class Utilities {

  public static Object[][] getAllLigandsAsObjects() {
    Object[][] sqlResults;

    try {
      ResultSet rs = DatabaseAccess.issueOrderedSqlQuery(
  		 "name,ligandId,isApproved,type,mass,synonyms",
       "ligands",
       "ligandId"
      );
      sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
    } catch (SQLException e) {
      /*sqlResults = new Object[1][6];
      sqlResults[0][0] = e.toString();
      sqlResults[0][1] = 0;
      sqlResults[0][2] = false;
      sqlResults[0][3] = "";
      sqlResults[0][4] = 0.0f;
      sqlResults[0][5] = "";*/
      sqlResults = new Object[0][0];

    }
    return sqlResults;
  }


  public static String[] getLigandRows(Object[][] sqlResults) {
		String[] rows = new String[sqlResults.length];

		for (int i = 0; i < rows.length; i++) {
			Object[] sqlRow = sqlResults[i];
			String name = (String)sqlRow[0];
			int id = (Integer)sqlRow[1];
			String hyperlink = String.format("/ligands/detail.jsp?id=%d", id);
			String approved = (Boolean)sqlRow[2] ? "Yes" : "No";
			String type = (String)sqlRow[3];
			float mass = (Float)sqlRow[4];
			String synonyms = ((String)sqlRow[5]).replace("#", ", ");
			String cells = String.format("%s%s%s%s%s%s",
					enclose("td", "value=\"" + name + "\"", enclose("a",String.format("href='%s'", hyperlink), name)),
					enclose("td", "value=\"" + id + "\"", "" + id),
					enclose("td", "value=\"" + approved + "\"", approved),
					enclose("td", "value=\"" + type + "\"", type),
					enclose("td", "value=\"" + mass + "\"", String.format("%f", mass)),
					enclose("td", "", synonyms));
			rows[i] = enclose("tr", "", cells);
		}
		return rows;
	}


  public static String enclose(String element, String attributes, String body) {
		return String.format("<%s %s>%s</%s>", element, attributes, body, element);
	}

}
