<%@include file="/includes/start.html"%>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
<link rel="stylesheet" href="/css/form.css">
<title>Search Sequences - SynPharm</title>
<%@include file="/includes/bodytop.html"%>

<h1>Search Sequences</h1>

<form action="/search/sequences/results.jsp" method="GET" class="pure-form pure-form-aligned">
	<div class="pure-g">

		<div class="pure-u-1-1 formrow" id="nameentry">
			<label for="targetname" class="pure-u-1-4">Target name:</label>
			<input class="pure-u-5-24" type="text" id="targetname" name="targetname" autocomplete="off">
		</div>

		<div class="pure-u-1-1 formrow" id="sequenceentry">
			<label for="sequence" class="pure-u-1-4">Sequence:</label>
			<input class="pure-u-11-24" type="text" id="sequence" name="sequence" autocomplete="off">
		</div>

		<div class="pure-u-1 formrow" id="lengthentry">
			<div class="pure-u-1-2" id="lengthgtentry">
				<label class="pure-u-1-2" for="lengthGt">Length greater than:</label>
				<input class="pure-u-5-24" type="text" id="lengthGt" name="lengthGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="lengthltentry">
				<label class="pure-u-1-2" for="lengthLt">Length less than:</label>
				<input class="pure-u-5-24" type="text" id="lengthLt" name="lengthLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="proplenhgtentry">
			<div class="pure-u-1-2" id="proplengthgtentry">
				<label class="pure-u-1-2" for="proplengthGt">Proportional length greater than:</label>
				<input class="pure-u-5-24" type="text" id="proplengthGt" name="proplengthGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="proplengthltentry">
				<label class="pure-u-1-2" for="proplengthLt">Proportional length less than:</label>
				<input class="pure-u-5-24" type="text" id="proplengthLt" name="proplengthLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="contactinentry">
			<div class="pure-u-1-2" id="contactingtentry">
				<label class="pure-u-1-2" for="contactinGt">Internal contacts greater than:</label>
				<input class="pure-u-5-24" type="text" id="contactinGt" name="contactinGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="contactinltentry">
				<label class="pure-u-1-2" for="contactinLt">Internal contacts less than:</label>
				<input class="pure-u-5-24" type="text" id="contactinLt" name="contactinLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="contactexentry">
			<div class="pure-u-1-2" id="contactexgtentry">
				<label class="pure-u-1-2" for="contactexGt">External contacts greater than:</label>
				<input class="pure-u-5-24" type="text" id="contactexGt" name="contactexGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="contactexltentry">
				<label class="pure-u-1-2" for="contactexLt">External contacts less than:</label>
				<input class="pure-u-5-24" type="text" id="contactexLt" name="contactexLt" size="5" autocomplete="off">
			</div>
		</div>

		<div class="pure-u-1 formrow" id="contactratioentry">
			<div class="pure-u-1-2" id="contactratiogtentry">
				<label class="pure-u-1-2" for="contactratioGt">Contact ratio greater than:</label>
				<input class="pure-u-5-24" type="text" id="contactratioGt" name="contactratioGt" size="5" autocomplete="off">
			</div>
			<div class="pure-u-11-24" id="contactratioltentry">
				<label class="pure-u-1-2" for="contactratioLt">Contact ratio less than:</label>
				<input class="pure-u-5-24" type="text" id="contactratioLt" name="contactratioLt" size="5" autocomplete="off">
			</div>
		</div>



		<div class="pure-u-1-2" id="typeentry">
			<label class="pure-u-1-2" for="typecheckbox">Target type:</label>
			<div id="typecheckbox"  class="pure-u-11-24">
				<div class="checkrow pure-u-1">
					<label for="alltype" class="pure-u-4-5 checklabel">All:</label>
					<input type="checkbox" class="pure-u-1-12" id="alltype" name="type" value="all" checked>
				</div>
				<div class="checkrow pure-u-1">
					<label for="gpcr" class="pure-u-4-5 checklabel">GPCR:</label>
					<input type="checkbox" class="pure-u-1-12" id="gpcr" name="type" value="GPCR">
				</div>
				<div class="checkrow pure-u-1">
					<label for="vgic" class="pure-u-4-5 checklabel">VGIC:</label>
					<input type="checkbox" class="pure-u-1-12" id="vgic" name="type" value="VGIC">
				</div>
				<div class="checkrow pure-u-1">
					<label for="lgic" class="pure-u-4-5 checklabel">LGIC:</label>
					<input type="checkbox" class="pure-u-1-12" id="lgic" name="type" value="LGIC">
				</div>
				<div class="checkrow pure-u-1">
					<label for="nhr" class="pure-u-4-5 checklabel">NHR:</label>
					<input type="checkbox" class="pure-u-1-12" id="nhr" name="type" value="NHR">
				</div>
				<div class="checkrow pure-u-1">
					<label for="enzyme" class="pure-u-4-5 checklabel">Enzyme:</label>
					<input type="checkbox" class="pure-u-1-12" id="enzyme" name="type" value="Enzyme">
				</div>
				<div class="checkrow pure-u-1">
					<label for="catalytic" class="pure-u-4-5 checklabel">Catalytic Receptor:</label>
					<input type="checkbox" class="pure-u-1-12" id="catalytic" name="type" value="CatalyticReceptor">
				</div>
				<div class="checkrow pure-u-1">
					<label for="other" class="pure-u-4-5 checklabel">Other Protein:</label>
					<input type="checkbox" class="pure-u-1-12" id="other" name="type" value="OtherProtein">
				</div>
			</div>
		</div>

		<div class="pure-u-1 formrow" id="checkentry">

			<div class="pure-u-1-2" id="specieseentry">
				<label class="pure-u-1-2" for="speciescheckbox">Species:</label>
				<div id="speciescheckbox"  class="pure-u-11-24">
					<div class="checkrow pure-u-1">
						<label for="alltype" class="pure-u-4-5 checklabel">All:</label>
						<input type="checkbox" class="pure-u-1-12" id="alltype" name="species" value="all" checked>
					</div>
					<div class="checkrow pure-u-1">
						<label for="human" class="pure-u-4-5 checklabel">Human:</label>
						<input type="checkbox" class="pure-u-1-12" id="human" name="species" value="human">
					</div>
					<div class="checkrow pure-u-1">
						<label for="mouse" class="pure-u-4-5 checklabel">Mouse:</label>
						<input type="checkbox" class="pure-u-1-12" id="mouse" name="species" value="mouse">
					</div>
					<div class="checkrow pure-u-1">
						<label for="rat" class="pure-u-4-5 checklabel">Rat:</label>
						<input type="checkbox" class="pure-u-1-12" id="rat" name="species" value="rat">
					</div>
				</div>
			</div>
			<div id="approvedentry" class="pure-u-11-24">
				<label for="approvedOnly" class="pure-u-18-24">Sequences with approved ligands only?</label>
				<input type="checkbox" class="pure-u-1-24" id="approvedOnly" name="approvedOnly" value="yes">
			</div>
		</div>
	</div>
</div>






<input type="submit" value="Search" class="pure-button pure-button-primary">

</form>

<%@include file="/includes/bodybottom.html"%>
