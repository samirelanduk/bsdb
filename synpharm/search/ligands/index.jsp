<%@include file="/includes/start.html"%>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
<link rel="stylesheet" href="/css/form.css">
<title>Search Ligands - SynPharm</title>
<%@include file="/includes/bodytop.html"%>

<h1>Search Ligands</h1>

<form action="/search/ligands/results.jsp" method="GET" class="pure-form pure-form-aligned">

	<div class="pure-g">

		<div class="pure-u-1-1 formrow" id="nameentry">
			<label for="ligandname" class="pure-u-1-4">Ligand name:</label>
			<input class="pure-u-5-24" type="text" id="ligandname" name="ligandname" autocomplete="off">
		</div>

		<div class="pure-u-1 formrow" id="massentry">
			<div class="pure-u-1-2" id="massgtentry">
				<label class="pure-u-1-2" for="massGt">Mass greater than:</label>
				<input class="pure-u-5-24" type="text" id="massGt" name="massGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="massltentry">
				<label class="pure-u-1-2" for="massLt">Mass less than:</label>
				<input class="pure-u-5-24" type="text" id="massLt" name="massLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="hbondaccentry">
			<div class="pure-u-1-2" id="hbondaccgtentry">
				<label class="pure-u-1-2" for="hbondAccGt">H-bond acceptors greater than:</label>
				<input class="pure-u-5-24" type="text" id="hbondAccGt" name="hbondAccGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="hbondaccltentry">
				<label class="pure-u-1-2" for="hbondAccLt">H-bond acceptors less than:</label>
				<input class="pure-u-5-24" type="text" id="hbondAccLt" name="hbondAccLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="hbonddonentry">
			<div class="pure-u-1-2" id="hbonddongtentry">
				<label class="pure-u-1-2" for="hbondDonGt">H-bond donors greater than:</label>
				<input class="pure-u-5-24" type="text" id="hbondDonGt" name="hbondDonGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="hbonddonltentry">
				<label class="pure-u-1-2" for="hbondDonGt">H-bond donors less than:</label>
				<input class="pure-u-5-24" type="text" id="hbondDonGt" name="hbondDonGt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="areaentry">
			<div class="pure-u-1-2" id="surfacegtentry">
				<label class="pure-u-1-2" for="surfaceGt">Polar surface area greater than:</label>
				<input class="pure-u-5-24" type="text" id="surfaceGt" name="surfaceGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="surfaceltentry">
				<label class="pure-u-1-2" for="surfaceLt">Polar surface area less than:</label>
				<input class="pure-u-5-24" type="text" id="surfaceLt" name="surfaceLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="lipinskientry">
			<div class="pure-u-1-2" id="lipinskigtentry">
				<label class="pure-u-1-2" for="lipinskiGt">Lipinski rules broken greater than:</label>
				<input class="pure-u-5-24" type="text" id="lipinskiGt" name="lipinskiGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="lipinskiltentry">
				<label class="pure-u-1-2" for="lipinskiLt">Lipinski rules broken less than:</label>
				<input class="pure-u-5-24" type="text" id="lipinskiLt" name="lipinskiLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="logpentry">
			<div class="pure-u-1-2" id="logpgtentry">
				<label class="pure-u-1-2" for="logpGt">logP greater than:</label>
				<input class="pure-u-5-24" type="text" id="logpGt" name="logpGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="logpltentry">
				<label class="pure-u-1-2" for="logpLt">logP less than:</label>
				<input class="pure-u-5-24" type="text" id="logpLt" name="logpLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="checkentry">

			<div class="pure-u-1-2" id="typeentry">
					<label class="pure-u-1-2" for="typecheckbox">Ligand type:</label>
					<div id="typecheckbox"  class="pure-u-11-24">
						<div class="checkrow pure-u-1">
							<label for="alltype" class="pure-u-4-5 checklabel">All:</label>
							<input type="checkbox" class="pure-u-1-12" id="alltype" name="type" value="all" checked>
						</div>
						<div class="checkrow pure-u-1">
							<label for="synthorg" class="pure-u-4-5 checklabel">Synthetic organic:</label>
							<input type="checkbox" class="pure-u-1-12" id="synthorg" name="type" value="Synthetic organic">
						</div>
						<div class="checkrow pure-u-1">
							<label for="metabolite" class="pure-u-4-5 checklabel">Metabolite:</label>
							<input type="checkbox" class="pure-u-1-12" id="metabolite" name="type" value="Metabolite">
						</div>
						<div class="checkrow pure-u-1">
							<label for="natprod" class="pure-u-4-5 checklabel">Natural product:</label>
							<input type="checkbox" class="pure-u-1-12" id="natprod" name="type" value="Natural product">
						</div>
						<div class="checkrow pure-u-1">
							<label for="othpep" class="pure-u-4-5 checklabel">Peptide:</label>
							<input type="checkbox" class="pure-u-1-12" id="pep" name="type" value="Peptide">
						</div>
						<div class="checkrow pure-u-1">
							<label for="inorganic" class="pure-u-4-5 checklabel">Inorganic:</label>
							<input type="checkbox" class="pure-u-1-12" id="inorganic" name="type" value="Inorganic">
						</div>
						<div class="checkrow pure-u-1">
							<label for="antibody" class="pure-u-4-5 checklabel">Antibody:</label>
							<input type="checkbox" class="pure-u-1-12" id="antibody" name="type" value="Antibody">
						</div>
					</div>
				</div>
				<div id="approvedentry" class="pure-u-11-24">
					<label for="approvedOnly" class="pure-u-1-2">Approved ligands only?</label>
					<input type="checkbox" class="pure-u-1-24" id="approvedOnly" name="approvedOnly" value="yes">
				</div>
		</div>
	</div>


	<input type="submit" value="Search" class="pure-button pure-button-primary">

</form>

<%@include file="/includes/bodybottom.html"%>
