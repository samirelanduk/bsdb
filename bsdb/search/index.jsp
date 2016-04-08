<%@include file="/includes/start.html"%>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
	<link rel="stylesheet" href="/css/form.css">
<title>Search - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Search</h1>

<div id="search_ligands">
	<h2>Ligands</h2>
		<form action="/search/ligands/results.jsp" method="GET" class="pure-form">
			<div id="nameentry">
				<label for="ligandname">Ligand name:</label>
				<input type="text" id="ligandname" name="ligandname" autocomplete="off">
			</div>
			<input type="submit" value="Search" class="pure-button pure-button-primary">
			<div class="detailed_search">
				<a href="/search/ligands">More Ligand Search options...</a>
			</div>
		</form>
</div>

<div id="search_sequences">
	<h2>Sequences</h2>
		<form action="/search/sequences/results.jsp" method="GET" class="pure-form">
			<div id="nameentry">
				<label for="targetname">Target name:</label>
				<input type="text" id="targetname" name="targetname" autocomplete="off">
			</div>
			<input type="submit" value="Search" class="pure-button pure-button-primary">
			<div class="detailed_search">
				<a href="/search/sequences">More Sequence Search options...</a>
			</div>
		</form>
</div>

<%@include file="/includes/bodybottom.html"%>
