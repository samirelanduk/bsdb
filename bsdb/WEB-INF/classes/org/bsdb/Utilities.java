package org.bsdb;

import java.sql.*;
import javax.servlet.http.HttpServletRequest;

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


  public static Object[][] getAllSequencesAsObjects() {
		Object[][] sqlResults;
		try {
			String query = "select sequences.interactionId,targets.name,sequences.species," +
			"ligands.name,sequences.length,sequences.originalChainLength, ligands.isApproved from sequences inner join targets on " +
			"sequences.targetId=targets.targetId inner join ligands on " +
			"sequences.ligandId=ligands.ligandId ORDER BY sequences.interactionId";
			ResultSet rs = DatabaseAccess.issueRawSqlQuery(query);
			sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		} catch (SQLException e) {
			sqlResults = new Object[0][0];
		}
		return sqlResults;
	}


  public static String[] getSequenceRows(Object[][] sqlResults) {
		String[] rows = new String[sqlResults.length];

		for (int i = 0; i < rows.length; i++) {
			Object[] sqlRow = sqlResults[i];
			int id = (Integer)sqlRow[0];
			String hyperlink = String.format("/sequences/detail.jsp?id=%d", id);
			String name = (String)sqlRow[1];
			String species = (String)sqlRow[2];
			String ligand = (String)sqlRow[3];
			int length = (Integer)sqlRow[4];
			String percent = Utilities.divideToPercentage(length, (Integer)sqlRow[5]);
			String approved = (Boolean)sqlRow[6] ? "Yes" : "No";
			String cells = String.format("%s%s%s%s%s%s%s",
					enclose("td", "value=\"" + id + "\"", enclose("a",String.format("href='%s'", hyperlink), "" + id)),
					enclose("td", "value=\"" + name + "\"", name),
					enclose("td", "value=\"" + species + "\"", species),
					enclose("td", "value=\"" + ligand + "\"", ligand),
					enclose("td", "value=\"" + length + "\"", "" + length),
					enclose("td", "value=\"" + percent.replace("%", "") + "\"", percent),
					enclose("td", "style=\"display: none\"", approved));
			rows[i] = enclose("tr", "", cells);
		}
		return rows;
	}


  public static Ligand getLigand(int ligandId) throws SQLException, ArrayIndexOutOfBoundsException {
		ResultSet rs = DatabaseAccess.issueRawSqlQuery("SELECT * FROM ligands WHERE ligandId=" + ligandId);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		return new Ligand(sqlResults[0]);
	}

  public static LigandLink[] getLigandLinks(int ligandId) {
		LigandLink[] links;
		try {
			ResultSet rs = DatabaseAccess.issueRawSqlQuery("SELECT * FROM ligandLinks WHERE ligandId=" + ligandId);
			Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
			links = new LigandLink[sqlResults.length];

			for (int i = 0; i < links.length; i++) {
				links[i] = new LigandLink(sqlResults[i]);
			}
		} catch (SQLException e) {
			links = new LigandLink[0];
		}
		return links;
	}

  public static Target getTarget(int targetId) throws SQLException, ArrayIndexOutOfBoundsException {
		ResultSet rs = DatabaseAccess.issueRawSqlQuery("SELECT * FROM targets WHERE targetId=" + targetId);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		return new Target(sqlResults[0]);
	}

	public static Sequence getSequence(int interactionId) throws SQLException, ArrayIndexOutOfBoundsException {
		ResultSet rs = DatabaseAccess.issueRawSqlQuery("SELECT * FROM sequences WHERE interactionId=" + interactionId);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		return new Sequence(sqlResults[0]);
	}

  public static Sequence[] getLigandSequences(int ligandId) {
		Sequence[] sequences;
		try {
			ResultSet rs = DatabaseAccess.issueRawSqlQuery("SELECT * FROM sequences WHERE ligandId=" + ligandId);
			Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
			sequences = new Sequence[sqlResults.length];

			for (int i = 0; i < sequences.length; i++) {
				sequences[i] = new Sequence(sqlResults[i]);
			}
		} catch (SQLException e) {
			sequences = new Sequence[0];
		}
		return sequences;
	}


  public static String enclose(String element, String attributes, String body) {
		return String.format("<%s %s>%s</%s>", element, attributes, body, element);
	}


  public static String stripHtml(String html) {
		html = html.replaceAll("<sub>", "");
		html = html.replaceAll("</sub>", "");

		return html;
	}

	public static String floatToPercentage(float value) {
		return String.format("%.1f%%", value * 100);
	}

	public static String divideToPercentage(int val1, int val2) {
		return floatToPercentage(val1 / Float.valueOf(val2));
	}


  public static boolean validParam(HttpServletRequest request, String param) {
		String paramValue = request.getParameter(param);
		if (paramValue == null) {
			return false;
		}
		for (int i = 0; i < paramValue.length(); i++) {
			if (!("0123456789".contains(paramValue.subSequence(i, i+1)))) {
				return false;
			}
		}
		return true;
	}

}
