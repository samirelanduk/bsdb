package org.synpharm;

import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

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
		 "SELECT ligandName, ligandId, approved, ligandType, mass, synonyms FROM ligands ORDER BY ligandId"
		);
		if (rs != null) {
			Object[][] sqlRows = getObjectGridFromResultSet(rs);
			return getLigandRowsFromObjectGrid(sqlRows);
		} else {
			return null;
		}
	}


	public static String[] getLigandRowsFromObjectGrid(Object[][] sqlRows) {
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
				String.format("value='%d' class='expendable'", id),
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
			 Utilities.enclose("td", "class='expendable'", synonyms)
			);
			tableRows[i] = Utilities.enclose("tr", "", cells);
		}
		return tableRows;
	}


	// Gets HTML rows for each sequence
	public static String[] getSequenceRows() {
		ResultSet rs = issuePreparedSqlQuery(
		 "SELECT s.sequenceId, s.targetName, s.species, l.ligandName, s.bindSequence, s.proportionalLength, l.approved, s.sequenceLength FROM sequences s INNER JOIN ligands l on s.ligandId=l.ligandId ORDER BY s.sequenceId"
		);
		if (rs != null) {
			Object[][] sqlRows = getObjectGridFromResultSet(rs);
			return getSequenceRowsFromObjectGrid(sqlRows);
		} else {
			return null;
		}
	}


	public static String[] getSequenceRowsFromObjectGrid(Object[][] sqlRows) {
		String[] tableRows = new String[sqlRows.length];
		for (int i = 0; i < sqlRows.length; i++) {
			Object[] row = sqlRows[i];
			int id = (Integer)row[0];
			String hyperlink = String.format("/sequences/detail.jsp?id=%d", id);
			int length = (Integer)row[7];
			String percent = Utilities.floatToPercentage((Float)row[5]);
			String approved = (Boolean)row[6] ? "Yes" : "No";
			String cells = String.format(
			 "%s%s%s%s%s%s%s",
			 Utilities.enclose(
				"td",
				String.format("value='%s'", row[0]),
				Utilities.enclose("a", String.format("href='%s'", hyperlink), "" + id)
			 ),
			 Utilities.enclose(
				"td",
				String.format("value='%s'", (String)row[1]),
				(String)row[1]
			 ),
			 Utilities.enclose(
				"td",
				String.format("value='%s'", (String)row[2]),
				(String)row[2]
			 ),
			 Utilities.enclose(
				"td",
				String.format("value='%s'", (String)row[3]),
				(String)row[3]
			 ),
			 Utilities.enclose(
				"td",
				String.format("value='%d' class='expendable'", length),
				String.format("%d", length)
			 ),
			 Utilities.enclose(
				"td",
				String.format("value='%s' class='expendable'", percent.replace("%", "")),
				percent
			 ),
			 Utilities.enclose("td", "style='display:none;'", approved)
			);
			tableRows[i] = Utilities.enclose("tr", "", cells);
		}
		return tableRows;
	}


	// Get Ligand Object by ID
	public static Ligand getLigand(int ligandId)  {
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT * FROM ligands WHERE ligandId=?",
		 ligandId
		);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		return new Ligand(sqlResults[0]);
	}


	// Get Sequence Object by ID
	public static Sequence getSequence(int sequenceId)  {
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT * FROM sequences WHERE sequenceId=?",
		 sequenceId
		);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		return new Sequence(sqlResults[0]);
	}


	// Get all LigandLinks for a given Ligand
	public static LigandLink[] getLigandLinks(int ligandId) {
		LigandLink[] links;
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT * FROM ligand_links WHERE ligandId=?",
		 ligandId
		);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		links = new LigandLink[sqlResults.length];
		for (int i = 0; i < links.length; i++) {
			links[i] = new LigandLink(sqlResults[i]);
		}
		return links;
	}

	// Get sequences for a ligand
	public static Sequence[] getLigandSequences(int ligandId) {
		Sequence[] sequences;
		ResultSet rs = issuePreparedSqlQuery("SELECT * FROM sequences WHERE ligandId=" + ligandId);
		Object[][] sqlResults = DatabaseAccess.getObjectGridFromResultSet(rs);
		sequences = new Sequence[sqlResults.length];

		for (int i = 0; i < sequences.length; i++) {
			sequences[i] = new Sequence(sqlResults[i]);
		}
		return sequences;
	}


	// Get ligand type counts
	public static long[] getLigandTypeCounts() {
		String[] ligandTypes = {
			 "Synthetic organic", "Metabolite", "Natural product",
			 "Peptide", "Inorganic", "Antibody"
		};
		long[] ligandTypeCounts = new long[7];
		for (int i = 0; i < 6; i++) {
			ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
			 "SELECT COUNT(*) FROM ligands WHERE ligandtype=?",
			 ligandTypes[i]
			);
			ligandTypeCounts[i] = (Long)getObjectGridFromResultSet(rs)[0][0];
		}
		return ligandTypeCounts;
	}


	public static Object[][] getLigandMassDistribution() {
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT mass FROM ligands ORDER BY mass DESC"
		);
		Object[][] grid = getObjectGridFromResultSet(rs);
		float[] masses = new float[grid.length];
		for (int i = 0; i < grid.length; i++) {
			masses[i] = (Float)(grid[i][0]);
		}
		ArrayList<Integer> boundaries = new ArrayList<Integer>();
		int value = 0;
		boundaries.add(value);
		while (boundaries.get(boundaries.size() - 1) < masses[0]) {
			boundaries.add(boundaries.get(boundaries.size() - 1) + 50);
		}
		String label;
		long count;
		int binCount = boundaries.size() - 1;

		Object[][] ligandMassDistribution = new Object[binCount][2];
		for (int i = 1; i < boundaries.size(); i++) {
			label = String.format("%d - %d", boundaries.get(i - 1), boundaries.get(i));
			count = 0;
			for (float mass : masses) {
				if ((mass > boundaries.get(i - 1)) && (mass <= boundaries.get(i))) {
					count++;
				}
			}
			ligandMassDistribution[i - 1][0] = label;
			ligandMassDistribution[i - 1][1] = count;
		}
		return ligandMassDistribution;
	}


	// Get ligand approval counts
	public static long[] getLigandApprovalCounts() {
		long[] ligandApprovalCounts = new long[2];
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT COUNT(*) FROM ligands WHERE approved=true"
		);
		ligandApprovalCounts[0] = (Long)getObjectGridFromResultSet(rs)[0][0];
		rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT COUNT(*) FROM ligands WHERE approved=false"
		);
		ligandApprovalCounts[1] = (Long)getObjectGridFromResultSet(rs)[0][0];
		return ligandApprovalCounts;
	}


	// Get sequence type counts
	public static long[] getSequenceTypeCounts() {
		String[] targetTypes = {
			 "GPCR", "LGIC", "VGIC", "OtherIC", "NHR", "Enzyme", "CatalyticReceptor",
			 "Transporter", "OtherProtein"
		};
		long[] sequenceTypeCounts = new long[9];
		for (int i = 0; i < 9; i++) {
			ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
			 "SELECT COUNT(*) FROM sequences WHERE targetType=?",
			 targetTypes[i]
			);
			sequenceTypeCounts[i] = (Long)getObjectGridFromResultSet(rs)[0][0];
		}
		return sequenceTypeCounts;
	}


	public static Object[][] getSequenceLengthDistribution() {
		ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
		 "SELECT sequenceLength FROM sequences ORDER BY sequenceLength DESC"
		);
		Object[][] grid = getObjectGridFromResultSet(rs);
		int[] lengths = new int[grid.length];
		for (int i = 0; i < grid.length; i++) {
			lengths[i] = (Integer)grid[i][0];
		}
		ArrayList<Integer> boundaries = new ArrayList<Integer>();
		int value = 0;
		boundaries.add(value);
		while (boundaries.get(boundaries.size() - 1) < lengths[0]) {
			boundaries.add(boundaries.get(boundaries.size() - 1) + 50);
		}
		String label;
		long count;
		int binCount = boundaries.size() - 1;

		Object[][] sequenceLengthDistribution = new Object[binCount][2];
		for (int i = 1; i < boundaries.size(); i++) {
			label = String.format("%d - %d", boundaries.get(i - 1), boundaries.get(i));
			count = 0;
			for (int length : lengths) {
				if ((length > boundaries.get(i - 1)) && (length <= boundaries.get(i))) {
					count++;
				}
			}
			sequenceLengthDistribution[i - 1][0] = label;
			sequenceLengthDistribution[i - 1][1] = count;
		}
		return sequenceLengthDistribution;
	}


	public static	ArrayList<int[][]> getSequenceContiguity() {
		String[] targetTypes = {
			 "GPCR", "LGIC", "VGIC", "OtherIC", "NHR", "Enzyme", "CatalyticReceptor",
			 "Transporter", "OtherProtein"
		};
		ArrayList<int[][]> sequenceContiguity = new ArrayList<int[][]>();
		for (int i = 0; i < targetTypes.length; i++) {
			ResultSet rs = DatabaseAccess.issuePreparedSqlQuery(
			 "SELECT sequences.sequenceLength, sequences.bindingResidues FROM sequences WHERE sequences.targetType=?",
			 targetTypes[i]
			);
			Object[][] grid = getObjectGridFromResultSet(rs);
			int[][] typeContiguity = new int[grid.length][2];
			for (int t = 0; t < grid.length; t++) {
				typeContiguity[t][0] = (Integer)(grid[t][0]);
				typeContiguity[t][1] = ((String)(grid[t][1])).length() - ((String)(grid[t][1])).replace(",", "").length();
			}
			sequenceContiguity.add(typeContiguity);
		}
		return sequenceContiguity;
	}
}
