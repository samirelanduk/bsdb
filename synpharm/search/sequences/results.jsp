<%@ page import = "org.synpharm.*" %>
<%@ page import = "java.util.*" %>
<%
	HashMap<String, Object> searchTerms = Utilities.processSequenceSearchRequest(request);
	String[] rows = Utilities.searchSequences(searchTerms);
%>

<%@include file="/includes/start.html"%>
<link rel="stylesheet" type="text/css" href="/css/list.css">
<link rel="stylesheet" type="text/css" href="/css/results.css">
<title>Sequence Search Results - BindSequenceDB</title>
<script src="/js/listsort.js"></script>
<%@include file="/includes/bodytop.html"%>

<h1>Sequence Search Results</h1>
<p>There <% out.print(rows.length == 1 ? "is" : "are"); %> <% out.print(rows.length); %> result<% out.print(rows.length == 1 ? "" : "s"); %> matching your query.</p>
<table id="list_table">
	<thead>
		<th onclick="sortColumn(0,false)" class="N">ID</th>
		<th onclick="sortColumn(1,false)" class="N">Target</th>
		<th onclick="sortColumn(2,false)" class="N">Species</th>
		<th onclick="sortColumn(3,false)" class="N">Ligand</th>
		<th onclick="sortColumn(4,false)" class="N">Length</th>
		<th onclick="sortColumn(5,false)" class="N">Proportional Length</th>
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
