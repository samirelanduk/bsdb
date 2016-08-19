<%@include file="/includes/start.html"%>
<title>About the Database - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>About the Database</h1>

<h2 id="gtop">The Guide to PHARMACOLOGY</h2>
<p>
	The <a href="http://guidetopharmacology.org" target="_blank">Guide to
	PHARMACOLOGY</a> (GtoPdb) is a searchable database with quantitative
	information on drug targets and the prescription medicines and experimental
	drugs that act on them. It was originally created in a collaboration between
	The British Pharmacological Society (BPS) and the International Union of Basic
	and Clinical Pharmacology (IUPHAR) and is now developed jointly with funding
	from the Wellcome Trust. It is intended to become a 'one-stop shop' portal to
	pharmacological information.
</p>
<p>
	This database is an annexe to the Guide to PHARMACOLOGY. All ligands contained
	here have a corresponding entry in GtoPdb, and all sequences are ultimately
	derived from an interaction between a GtoPdb ligand and a GtoPdb target.
</p>

<h2>SynPharm</h2>
<p>
	SynPharm is a database of ligand-responsive protein sequences, derived from
	interactions from the Guide to PHARMACOLOGY and using data from the
	<a href="http://rscb.org" target="_blank">Protein Data Bank</a>.
</p>
<p>
	The sequences here are obtained by identifying the protein chain that
	interacts with a ligand for a given Guide to PHARMACOLOGY interaction,
	determining the binding residues, and producing a continuous 'bind sequence'
	that can be used to confer drugability to another protein.
</p>
<p>
	Each bind sequence also contains metrics such as atomic contact ratio and
	proportional length, and visualisations such as the residue distance matrix,
	to allow you to better judge whether a sequence is likely to be able to fold
	independently.
</p>
<p>
	The rationale for such a project was to enable the development of orthogonal
	molecular switches - switches which only respond to an exogenous molecular
	trigger, which itself will not interfere with endogenous receptors.
</p>

<div id="aboutback">
	<a href="/about">Back to About</a>
</div>

<%@include file="/includes/bodybottom.html"%>
