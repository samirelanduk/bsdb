<%@ page import = "org.bsdb.*" %>
<%@ page import = "java.util.*" %>
<%
	HashMap<String, Object> searchTerms = Utilities.processSequenceSearchRequest(request);
	String[] rows = Utilities.searchSequences(searchTerms);
%>

<%@include file="/includes/start.html"%>
<title>Sequence Search Results - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Sequence Search Results</h1>
<table id="list_table">
	<thead>
		<th>ID</th>
		<th>Target</th>
		<th>Species</th>
		<th>Ligand</th>
		<th>Length</th>
		<th>Proportional Length</th>
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
