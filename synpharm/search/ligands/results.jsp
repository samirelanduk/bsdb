<%@ page import = "org.synpharm.*" %>
<%@ page import = "java.util.*" %>
<%
	HashMap<String, Object> searchTerms = Utilities.processLigandSearchRequest(request);
	String[] rows = Utilities.searchLigands(searchTerms);
%>

<%@include file="/includes/start.html"%>
<link rel="stylesheet" type="text/css" href="/css/list.css">
<link rel="stylesheet" type="text/css" href="/css/results.css">
<title>Ligand Search Results - BindSequenceDB</title>
<script src="/js/listsort.js"></script>
<%@include file="/includes/bodytop.html"%>

<h1>Ligand Search Results</h1>
<p>There <% out.print(rows.length == 1 ? "is" : "are"); %> <% out.print(rows.length); %> result<% out.print(rows.length == 1 ? "" : "s"); %> matching your query.</p>
<table id="list_table">
	<thead>
		<th onclick="sortColumn(0,false)" class="N">Name</th>
		<th onclick="sortColumn(1,false)" class="N">ID</th>
		<th onclick="sortColumn(2,false)" class="N">Approved</th>
		<th onclick="sortColumn(3,false)" class="N expendable">Type</th>
		<th onclick="sortColumn(4,false)" class="N expendable">Mass</th>
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
