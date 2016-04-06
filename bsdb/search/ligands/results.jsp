<%@ page import = "org.bsdb.*" %>
<%@ page import = "java.util.*" %>
<%
	HashMap<String, Object> searchTerms = Utilities.processLigandSearchRequest(request);
	String[] rows = Utilities.searchLigands(searchTerms);
%>

<%@include file="/includes/start.html"%>
<title>Ligand Search Results - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Ligand Search Results</h1>
<table id="list_table">
	<thead>
		<th>Name</th>
		<th>ID</th>
		<th>Approved</th>
		<th>Type</th>
		<th>Mass</th>
		<th>Synonyms</th>
	</thead>
	<tbody>
	<%
	for (String row : rows) {
		out.println(row);
	}
	%>
	</tbody>
</table>

<%@include file="/includes/bodybottom.html"%>
