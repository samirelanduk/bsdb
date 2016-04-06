<%@include file="/includes/start.html"%>
<title>Search Sequences - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Search Sequences</h1>

<form action="/search/sequences/results.jsp" method="GET">

<div id="nameentry">
	<label for="targetname">Target name:</label>
	<input type="text" id="targetname" name="targetname">
</div>
<div id="sequenceentry">
	<label for="targetname">Sequence:</label>
	<input type="text" id="sequence" name="sequence">
	<div>Note this will find exact matches only.</div>
</div>


<div id="lengthgtentry">
	<label for="lengthGt">Sequence length greater than:</label>
	<input type="text" id="lengthGt" name="lengthGt" size="5">
</div>
<div id="lengthltentry">
	<label for="lengthLt">Sequence length less than:</label>
	<input type="text" id="lengthLt" name="lengthLt" size="5">
</div>
<div id="proplengthgtentry">
	<label for="proplengthGt">Proportional sequence length greater than:</label>
	<input type="text" id="proplengthGt" name="proplengthGt" size="5">
</div>
<div id="proplengthltentry">
	<label for="proplengthLt">Proportional sequence length less than:</label>
	<input type="text" id="proplengthLt" name="proplengthLt" size="5">
</div>

<div id="contactingtentry">
	<label for="contactinGt">Internal contacts greater than:</label>
	<input type="text" id="contactinGt" name="contactinGt" size="5">
</div>
<div id="contactinltentry">
	<label for="contactinLt">Internal contacts less than:</label>
	<input type="text" id="contactinLt" name="contactinLt" size="5">
</div>

<div id="contactexgtentry">
	<label for="massGt">External contacts greater than:</label>
	<input type="text" id="contactexGt" name="contactexGt" size="5">
</div>
<div id="contactexltentry">
	<label for="contactexLt">External contacts less than:</label>
	<input type="text" id="contactexLt" name="contactexLt" size="5">
</div>

<div id="contactratiogtentry">
	<label for="contactratio">Contact ratio greater than:</label>
	<input type="text" id="contactratioGt" name="contactratioGt" size="5">
</div>
<div id="contactratioltentry">
	<label for="contactratioLt">Contact ratio less than:</label>
	<input type="text" id="contactratioLt" name="contactratioLt" size="5">
</div>

<label>Target type:</label>
<div id="typeentry">
	<label for="alltype">All:</label>
	<input type="checkbox" id="alltype" name="type" value="all" checked>
	<label for="gpcr">GPCR</label>
	<input type="checkbox" id="gpcr" name="type" value="GPCR">
	<label for="vgic">VGIC</label>
	<input type="checkbox" id="vgic" name="type" value="VGIC">
	<label for="lgic">LGIC</label>
	<input type="checkbox" id="lgic" name="type" value="LGIC">
	<label for="nhr">NHR</label>
	<input type="checkbox" id="nhr" name="type" value="NHR">
	<label for="enzyme">Enzyme</label>
	<input type="checkbox" id="enzyme" name="type" value="Enzyme">
	<label for="catalytic">Catalytic Receptor</label>
	<input type="checkbox" id="catalytic" name="type" value="CatalyticReceptor">
	<label for="other">Other Protein</label>
	<input type="checkbox" id="other" name="type" value="OtherProtein">
</div>

<label>Species:</label>
<div id="speciesentry">
	<label for="allspecies">All:</label>
	<input type="checkbox" id="allspecies" name="species" value="all" checked>
	<label for="human">Human</label>
	<input type="checkbox" id="human" name="species" value="human">
	<label for="mouse">Mouse</label>
	<input type="checkbox" id="mouse" name="species" value="mouse">
	<label for="rat">Rat</label>
	<input type="checkbox" id="rat" name="species" value="rat">
</div>

<div id="approvedentry">
	<label for="approvedOnly">Sequences with approved ligands only?</label>
	<input type="checkbox" id="approvedOnly" name="approvedOnly" value="yes">
</div>


<input type="submit" value="Search">

</form>

<%@include file="/includes/bodybottom.html"%>