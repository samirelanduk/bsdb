<%@include file="/includes/start.html"%>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
<link rel="stylesheet" href="/css/form.css">
<title>Search Ligands - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Search Ligands</h1>

<form action="/search/ligands/results.jsp" method="GET" class="pure-form pure-form-aligned">

<div class="pure-control-group" id="nameentry">
	<label for="ligandname">Ligand name:</label>
	<input type="text" id="ligandname" name="ligandname" autocomplete="off">
</div>


<div class="pure-control-group" id="massgtentry">
	<label for="massGt">Mass greater than:</label>
	<input type="text" id="massGt" name="massGt" size="5" autocomplete="off">
</div>
<div class="pure-control-group" id="massltentry">
	<label for="massLt">Mass less than:</label>
	<input type="text" id="massLt" name="massLt" size="5" autocomplete="off">
</div>

<div class="pure-control-group" id="hbondaccgtentry">
	<label for="massGt">H-bond acceptors greater than:</label>
	<input type="text" id="hbondAccGt" name="hbondAccGt" size="5" autocomplete="off">
</div>
<div class="pure-control-group" id="hbondaccltentry">
	<label for="massLt">H-bond acceptors less than:</label>
	<input type="text" id="hbondAccLt" name="hbondAccLt" size="5" autocomplete="off">
</div>

<div class="pure-control-group" id="hbonddongtentry">
	<label for="massGt">H-bond donors greater than:</label>
	<input type="text" id="hbondDonGt" name="hbondDonGt" size="5" autocomplete="off">
</div>
<div class="pure-control-group" id="hbonddonltentry">
	<label for="massLt">H-bond donors less than:</label>
	<input type="text" id="hbondDonLt" name="hbondDonLt" size="5" autocomplete="off">
</div>

<div class="pure-control-group" id="surfacegtentry">
	<label for="massGt">Polar surface area greater than:</label>
	<input type="text" id="surfaceGt" name="surfaceGt" size="5" autocomplete="off">
</div>
<div class="pure-control-group" id="surfaceltentry">
	<label for="massLt">Polar surface area less than:</label>
	<input type="text" id="surfaceLt" name="surfaceLt" size="5" autocomplete="off">
</div>

<div class="pure-control-group" id="lipinskigtentry">
	<label for="massGt">Lipinski rules broken greater than:</label>
	<input type="text" id="lipinskiGt" name="lipinskiGt" size="5" autocomplete="off">
</div>
<div class="pure-control-group" id="lipinskiltentry">
	<label for="massLt">Lipinski rules broken less than:</label>
	<input type="text" id="lipinskiLt" name="lipinskiLt" size="5" autocomplete="off">
</div>

<div class="pure-control-group" id="logpgtentry">
	<label for="massGt">logP greater than:</label>
	<input type="text" id="logpGt" name="logpGt" size="5" autocomplete="off">
</div>
<div class="pure-control-group" id="logpltentry">
	<label for="massLt">logP less than:</label>
	<input type="text" id="logpLt" name="logpLt" size="5" autocomplete="off">
</div>

<div class="pure-control-group" id="typeentry">
	<label for ="typecheckbox">Ligand type:</label>
	<div id="typecheckbox">
		<label for="alltype">All:</label>
		<input type="checkbox" id="alltype" name="type" value="all" checked>
		<label for="synthorg">Synthetic organic</label>
		<input type="checkbox" id="synthorg" name="type" value="Synthetic organic">
		<label for="metabolite">Metabolite</label>
		<input type="checkbox" id="metabolite" name="type" value="Metabolite">
		<label for="natprod">Natural product</label>
		<input type="checkbox" id="natprod" name="type" value="Natural product">
		<label for="endpep">Endogenous peptide</label>
		<input type="checkbox" id="endpep" name="type" value="Endogenous peptide">
		<label for="othpep">Other peptide</label>
		<input type="checkbox" id="othpep" name="type" value="Other peptide">
		<label for="inorganic">Inorganic</label>
		<input type="checkbox" id="inorganic" name="type" value="Inorganic">
		<label for="antibody">Antibody</label>
		<input type="checkbox" id="antibody" name="type" value="Antibody">
	</div>
</div>

<div class="pure-control-group" id="approvedentry">
	<label for="approvedOnly">Approved ligands only?</label>
	<input type="checkbox" id="approvedOnly" name="approvedOnly" value="yes">
</div>


<input type="submit" value="Search">

</form>

<%@include file="/includes/bodybottom.html"%>
