<%@include file="/includes/start.html"%>
<title>Search - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Search</h1>

<div id="search_ligands">
	<form action="/search/ligands/results.jsp" method="GET">
		<div id="nameentry">
			<label for="ligandname">Ligand name:</label>
			<input type="text" id="ligandname" name="ligandname">
		</div>
		<input type="submit" value="Search">
	</form>
	<div id="detailed_search">
		<a href="/search/ligands">More Ligand Search options...</a>
	</div>
</div>

<div id="search_ligands">
	<form action="/search/sequences/results.jsp" method="GET">
		<div id="nameentry">
			<label for="targetname">Target name:</label>
			<input type="text" id="targetname" name="targetname">
		</div>
		<input type="submit" value="Search">
	</form>
	<div id="detailed_search">
		<a href="/search/sequences">More Sequence Search options...</a>
	</div>
</div>

<%@include file="/includes/bodybottom.html"%>
