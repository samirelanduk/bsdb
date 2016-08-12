package org.synpharm;

import java.sql.*;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

public class Utilities {

  public static String enclose(String element, String attributes, String body) {
		return String.format("<%s %s>%s</%s>", element, attributes, body, element);
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


  public static String stripHtml(String html) {
		html = html.replaceAll("<sub>", "");
		html = html.replaceAll("</sub>", "");
		return html;
	}


  public static int getSequenceLength(String sequence) {
    int firstUpper = 0;
		for (int i = 0; i < sequence.length(); i++) {
			if (Character.isUpperCase(sequence.charAt(i))) {
				firstUpper = i;
				break;
			}
		}
		int lastUpper = sequence.length();
		for (int i = sequence.length() - 1; i > 0; i--) {
			if (Character.isUpperCase(sequence.charAt(i))) {
				lastUpper = i;
				break;
			}
		}
		return (lastUpper - firstUpper) + 1;
  }


  // Takes a Ligand Search request and produces a HashMap of the query
	public static HashMap<String, Object> processLigandSearchRequest(HttpServletRequest request) {
		HashMap<String, Object> searchTerms = new HashMap<String, Object>();
		Map<String, String[]> paramNames = request.getParameterMap();

		String[] stringParams = {"ligandname", "accession"};
		String[] intParams = {"hbondAccGt", "hbondAccLt", "hbondDonGt", "hbondDonLt", "lipinskiGt", "lipinskiLt"};
		String[] floatParams = {"massGt", "massLt", "surfaceGt", "surfaceLt", "logpGt", "logpLt"};
		String[] boolParams = {"approvedOnly"};

		for (String paramName : paramNames.keySet()) {
			if (Arrays.asList(stringParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;#]","");
				if (cleanValue.length() >= 1) {
					searchTerms.put(paramName, cleanValue);
				}
			} else if (Arrays.asList(intParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Integer.parseInt((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not an integer
				}
			} else if (Arrays.asList(floatParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Float.parseFloat((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not a float
				}
			} else if (Arrays.asList(boolParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				if (cleanValue.equals("yes")) {
					searchTerms.put("approvedOnly", true);
				}
			} else if (paramName.equals("type")) {
				String[] types = paramNames.get("type");
				ArrayList<String> validTypes = new ArrayList<String>();
				for (String type : types) {
					String cleanValue = type.replaceAll("[;]","");
					if (!(cleanValue.equals("all"))) {
						validTypes.add(cleanValue);
					}
				}
				if (validTypes.size() >= 1) {
					searchTerms.put("types", validTypes);
				}
			}
		}

		return searchTerms;
	}


	// Takes a Sequence Search request and produces a HashMap of the query
	public static HashMap<String, Object> processSequenceSearchRequest(HttpServletRequest request) {
		HashMap<String, Object> searchTerms = new HashMap<String, Object>();
		Map<String, String[]> paramNames = request.getParameterMap();

		String[] stringParams = {"targetname", "sequence"};
		String[] intParams = {"lengthGt", "lengthLt", "contactinGt", "contactinLt", "contactexGt", "contactexLt"};
		String[] floatParams = {"proplengthGt", "proplengthLt", "contactratioGt", "contactratioLt"};
		String[] boolParams = {"approvedOnly"};

		for (String paramName : paramNames.keySet()) {
			if (Arrays.asList(stringParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;#]","");
				if (cleanValue.length() >= 1) {
					searchTerms.put(paramName, cleanValue);
				}
			} else if (Arrays.asList(intParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Integer.parseInt((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not an integer
				}
			} else if (Arrays.asList(floatParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Float.parseFloat((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not a float
				}
			} else if (Arrays.asList(boolParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				if (cleanValue.equals("yes")) {
					searchTerms.put("approvedOnly", true);
				}
			} else if (paramName.equals("type")) {
				String[] types = paramNames.get("type");
				ArrayList<String> validTypes = new ArrayList<String>();
				for (String type : types) {
					String cleanValue = type.replaceAll("[;]","");
					if (!(cleanValue.equals("all"))) {
						validTypes.add(cleanValue);
					}
				}
				if (validTypes.size() >= 1) {
					searchTerms.put("types", validTypes);
				}
			} else if (paramName.equals("species")) {
				String[] types = paramNames.get("species");
				ArrayList<String> validSpecies = new ArrayList<String>();
				for (String type : types) {
					String cleanValue = type.replaceAll("[;]","");
					if (!(cleanValue.equals("all"))) {
						validSpecies.add(cleanValue);
					}
				}
				if (validSpecies.size() >= 1) {
					searchTerms.put("species", validSpecies);
				}
			}
		}

		return searchTerms;
	}


  public static String[] searchLigands(HashMap<String, Object> searchTerms) {
		String[] ligandRows;
		ArrayList<String> conditions = new ArrayList<String>();

		if (searchTerms.containsKey("ligandname")) {
			conditions.add(String.format("(ligandName LIKE '%%%s%%' OR synonyms LIKE '%%%s%%')", searchTerms.get("ligandname"), searchTerms.get("ligandname")));
		}
		if (searchTerms.containsKey("types")) {
			StringBuilder typeCondition = new StringBuilder("(");
			for (String type : (ArrayList<String>)searchTerms.get("types")) {
				typeCondition.append("ligandType=\'" + type + "\' OR ");
			}
			typeCondition.delete(typeCondition.length() - 4, typeCondition.length());
			typeCondition.append(")");
			conditions.add(typeCondition.toString());
		}
		if (searchTerms.containsKey("massGt")) {
			conditions.add(String.format("mass>=%f", searchTerms.get("massGt")));
		}
		if (searchTerms.containsKey("massLt")) {
			conditions.add(String.format("mass<=%f", searchTerms.get("massLt")));
		}
		if (searchTerms.containsKey("hbondAccGt")) {
			conditions.add(String.format("hBondAcceptors>=%d", searchTerms.get("hbondAccGt")));
		}
		if (searchTerms.containsKey("hbondAccLt")) {
			conditions.add(String.format("hBondAcceptors<=%d", searchTerms.get("hbondAccLt")));
		}
		if (searchTerms.containsKey("hbondDonGt")) {
			conditions.add(String.format("hBondDonors>=%d", searchTerms.get("hbondDonGt")));
		}
		if (searchTerms.containsKey("hbondDonLt")) {
			conditions.add(String.format("hBondDonors<=%d", searchTerms.get("hbondDonLt")));
		}
		if (searchTerms.containsKey("surfaceGt")) {
			conditions.add(String.format("surfaceArea>=%f", searchTerms.get("surfaceGt")));
		}
		if (searchTerms.containsKey("surfaceLt")) {
			conditions.add(String.format("surfaceArea<=%f", searchTerms.get("surfaceLt")));
		}
		if (searchTerms.containsKey("lipinskiGt")) {
			conditions.add(String.format("lipinskirulesbroken>=%d", searchTerms.get("lipinskiGt")));
		}
		if (searchTerms.containsKey("lipinskiLt")) {
			conditions.add(String.format("lipinskirulesbroken<=%d", searchTerms.get("lipinskiLt")));
		}
		if (searchTerms.containsKey("logpGt")) {
			conditions.add(String.format("logP>=%f", searchTerms.get("logpGt")));
		}
		if (searchTerms.containsKey("logpLt")) {
			conditions.add(String.format("logP<=%f", searchTerms.get("logpLt")));
		}
		if ((searchTerms.containsKey("approvedOnly")) && (boolean)(searchTerms.get("approvedOnly"))) {
			conditions.add("approved=true");
		}

		StringBuilder query = new StringBuilder("SELECT ligandName,ligandId,approved,ligandType,mass,synonyms FROM ligands");
		if (conditions.size() >= 1) {
			query.append(" WHERE");
			for (String condition : conditions) {
				query.append(" " + condition + " AND");
			}
			query.delete(query.length() - 4, query.length());
		}
		query.append(";");
		Object[][] sqlResults;
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(query.toString());
	  sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		ligandRows = DatabaseAccess.getLigandRowsFromObjectGrid(sqlResults);
		return ligandRows;
	}

	public static String[] searchSequences(HashMap<String, Object> searchTerms) {
		String[] sequenceRows;
		ArrayList<String> conditions = new ArrayList<String>();

		if (searchTerms.containsKey("targetname")) {
			conditions.add(String.format("sequences.targetName LIKE '%%%s%%'", searchTerms.get("targetname")));
		}
		if (searchTerms.containsKey("sequence")) {
			conditions.add(String.format("sequences.bindSequence LIKE '%%%s%%'", searchTerms.get("sequence")));
		}
		if (searchTerms.containsKey("types")) {
			StringBuilder typeCondition = new StringBuilder("(");
			for (String type : (ArrayList<String>)searchTerms.get("types")) {
				typeCondition.append("sequences.targetType=\'" + type + "\' OR ");
			}
			typeCondition.delete(typeCondition.length() - 4, typeCondition.length());
			typeCondition.append(")");
			conditions.add(typeCondition.toString());
		}
		if (searchTerms.containsKey("species")) {
			StringBuilder typeCondition = new StringBuilder("(");
			for (String type : (ArrayList<String>)searchTerms.get("species")) {
				typeCondition.append("LOWER(sequences.species)=\'" + type + "\' OR ");
			}
			typeCondition.delete(typeCondition.length() - 4, typeCondition.length());
			typeCondition.append(")");
			conditions.add(typeCondition.toString());
		}
		if (searchTerms.containsKey("lengthGt")) {
			conditions.add(String.format("length(sequences.bindSequence)>=%d", searchTerms.get("lengthGt")));
		}
		if (searchTerms.containsKey("lengthLt")) {
			conditions.add(String.format("length(sequences.bindSequence)<=%d", searchTerms.get("lengthLt")));
		}
		if (searchTerms.containsKey("proplengthGt")) {
			conditions.add(String.format("sequences.proportionalLength>=%f", searchTerms.get("proplengthGt")));
		}
		if (searchTerms.containsKey("proplengthLt")) {
			conditions.add(String.format("sequences.proportionalLength<=%f", searchTerms.get("proplengthLt")));
		}
		if (searchTerms.containsKey("contactinGt")) {
			conditions.add(String.format("sequences.internalContacts>=%d", searchTerms.get("contactinGt")));
		}
		if (searchTerms.containsKey("contactinLt")) {
			conditions.add(String.format("sequences.internalContacts<=%d", searchTerms.get("contactinLt")));
		}
		if (searchTerms.containsKey("contactexGt")) {
			conditions.add(String.format("sequences.externalContacts>=%d", searchTerms.get("contactexGt")));
		}
		if (searchTerms.containsKey("contactexLt")) {
			conditions.add(String.format("sequences.externalContacts<=%d", searchTerms.get("contactexLt")));
		}
		if (searchTerms.containsKey("contactratioGt")) {
			conditions.add(String.format("sequences.contactRatio>=%f", searchTerms.get("contactratioGt")));
		}
		if (searchTerms.containsKey("contactratioLt")) {
			conditions.add(String.format("sequences.contactRatio<=%f", searchTerms.get("contactratioLt")));
		}
		if ((searchTerms.containsKey("approvedOnly")) && (boolean)(searchTerms.get("approvedOnly"))) {
			conditions.add("ligands.approved=true");
		}
		String queryStart = "select sequences.sequenceId,sequences.targetName,sequences.species," +
				"ligands.ligandName,sequences.bindSequence,sequences.proportionalLength, ligands.approved from sequences" +
				" inner join ligands on sequences.ligandId=ligands.ligandId";
		StringBuilder query = new StringBuilder(queryStart);
		if (conditions.size() >= 1) {
			query.append(" WHERE");
			for (String condition : conditions) {
				query.append(" " + condition + " AND");
			}
			query.delete(query.length() - 4, query.length());
		}
		query.append(";");
		Object[][] sqlResults;
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(query.toString());
		sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		sequenceRows = DatabaseAccess.getSequenceRowsFromObjectGrid(sqlResults);
		return sequenceRows;
	}

  /*public static Object[][] getAllLigandsAsObjects() {
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
      sqlResults[0][5] = "";
      sqlResults = new Object[0][0];

    }
    return sqlResults;
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



  public static HashMap<String, Object> processLigandSearchRequest(HttpServletRequest request) {
		HashMap<String, Object> searchTerms = new HashMap<String, Object>();
		Map<String, String[]> paramNames = request.getParameterMap();

		String[] stringParams = {"ligandname", "accession"};
		String[] intParams = {"hbondAccGt", "hbondAccLt", "hbondDonGt", "hbondDonLt", "lipinskiGt", "lipinskiLt"};
		String[] floatParams = {"massGt", "massLt", "surfaceGt", "surfaceLt", "logpGt", "logpLt"};
		String[] boolParams = {"approvedOnly"};

		for (String paramName : paramNames.keySet()) {
			if (Arrays.asList(stringParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;#]","");
				if (cleanValue.length() >= 1) {
					searchTerms.put(paramName, cleanValue);
				}
			} else if (Arrays.asList(intParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Integer.parseInt((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not an integer
				}
			} else if (Arrays.asList(floatParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Float.parseFloat((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not a float
				}
			} else if (Arrays.asList(boolParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				if (cleanValue.equals("yes")) {
					searchTerms.put("approvedOnly", true);
				}
			} else if (paramName.equals("type")) {
				String[] types = paramNames.get("type");
				ArrayList<String> validTypes = new ArrayList<String>();
				for (String type : types) {
					String cleanValue = type.replaceAll("[;]","");
					if (!(cleanValue.equals("all"))) {
						validTypes.add(cleanValue);
					}
				}
				if (validTypes.size() >= 1) {
					searchTerms.put("types", validTypes);
				}
			}
		}

		return searchTerms;
	}

	public static HashMap<String, Object> processSequenceSearchRequest(HttpServletRequest request) {
		HashMap<String, Object> searchTerms = new HashMap<String, Object>();
		Map<String, String[]> paramNames = request.getParameterMap();

		String[] stringParams = {"targetname", "sequence"};
		String[] intParams = {"lengthGt", "lengthLt", "contactinGt", "contactinLt", "contactexGt", "contactexLt"};
		String[] floatParams = {"proplengthGt", "proplengthLt", "contactratioGt", "contactratioLt"};
		String[] boolParams = {"approvedOnly"};

		for (String paramName : paramNames.keySet()) {
			if (Arrays.asList(stringParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;#]","");
				if (cleanValue.length() >= 1) {
					searchTerms.put(paramName, cleanValue);
				}
			} else if (Arrays.asList(intParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Integer.parseInt((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not an integer
				}
			} else if (Arrays.asList(floatParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				try {
					if (cleanValue.length() >= 1) {
						searchTerms.put(paramName, Float.parseFloat((cleanValue)));
					}
				} catch (NumberFormatException e) {
					// Not a float
				}
			} else if (Arrays.asList(boolParams).contains(paramName)) {
				String cleanValue = paramNames.get(paramName)[0].replaceAll("[;]","");
				if (cleanValue.equals("yes")) {
					searchTerms.put("approvedOnly", true);
				}
			} else if (paramName.equals("type")) {
				String[] types = paramNames.get("type");
				ArrayList<String> validTypes = new ArrayList<String>();
				for (String type : types) {
					String cleanValue = type.replaceAll("[;]","");
					if (!(cleanValue.equals("all"))) {
						validTypes.add(cleanValue);
					}
				}
				if (validTypes.size() >= 1) {
					searchTerms.put("types", validTypes);
				}
			} else if (paramName.equals("species")) {
				String[] types = paramNames.get("species");
				ArrayList<String> validSpecies = new ArrayList<String>();
				for (String type : types) {
					String cleanValue = type.replaceAll("[;]","");
					if (!(cleanValue.equals("all"))) {
						validSpecies.add(cleanValue);
					}
				}
				if (validSpecies.size() >= 1) {
					searchTerms.put("species", validSpecies);
				}
			}
		}

		return searchTerms;
	}

	public static String mapToString(HashMap<String, Object> searchTerms) {
		StringBuilder s = new StringBuilder();
		for (String paramName : searchTerms.keySet()) {
			if (searchTerms.get(paramName) instanceof ArrayList<?>) {
				StringBuilder typeString = new StringBuilder();
				ArrayList<String> types = (ArrayList<String>)searchTerms.get(paramName);
				for (String type : types) {
					typeString.append(type + ", ");
				}
				s.append(String.format("%s: %s, ", paramName, typeString.toString().substring(0, typeString.length() - 2)));
			} else {
				s.append(String.format("%s: %s, ", paramName, searchTerms.get(paramName).toString()));
			}
		}
		return s.toString().substring(0, s.length() >= 2 ? s.length() - 2 : s.length());
	}

	*/


}
