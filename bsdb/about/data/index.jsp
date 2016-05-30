<%@ page import = "org.bsdb.*" %>
<%
long[] ligandTypeCounts = DatabaseAccess.getLigandTypeCounts();
%>

<%@include file="/includes/start.html"%>
<title>Data and Statistics - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Data and Statistics</h1>

<div id="ligand_stats">

	<div class="box">
		<div class="box_title">
			Ligands by Type
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the ligands in the BSDV database by Guide to PHARMACOLOGY
				type.
			</div>
			<table>
				<tr><td>Synthetic Organic</td><td><% out.print(ligandTypeCounts[0]); %></td></tr>
				<tr><td>Metabolite</td><td><% out.print(ligandTypeCounts[1]); %></td></tr>
				<tr><td>Natural Product</td><td><% out.print(ligandTypeCounts[2]); %></td></tr>
				<tr><td>Endogenous Peptide</td><td><% out.print(ligandTypeCounts[3]); %></td></tr>
				<tr><td>Other Peptide</td><td><% out.print(ligandTypeCounts[4]); %></td></tr>
				<tr><td>Inorganic</td><td><% out.print(ligandTypeCounts[5]); %></td></tr>
				<tr><td>Antibody</td><td><% out.print(ligandTypeCounts[6]); %></td></tr>
			</table>
			<svg>
			</svg>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Ligands by Mass
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Ligands by Approval Status
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

</div>

<div id="sequence_stats">

	<div class="box">
		<div class="box_title">
			Sequences by Target Type
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Sequences by Mass
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Sequence Contiguity by Target Type
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

</div>

<div id="aboutback">
	<a href="/about">Back to About</a>
</div>

<%@include file="/includes/bodybottom.html"%>
