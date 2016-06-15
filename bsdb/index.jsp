<%@ page import = "org.bsdb.*" %>

<%
long[] ligandTypeCounts = DatabaseAccess.getLigandTypeCounts();
long[] sequenceTypeCounts = DatabaseAccess.getSequenceTypeCounts();
%>

<%@include file="/includes/start.html"%>
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<style>
  #detail_container {
    border: 0px;
  }
  .box table {
    margin-top: 20px;
    margin-bottom: 20px;
  }
  .box td {
    border: 1px solid #D1D0CE;
  }
  .entity-description {
    margin-top: 10px;
  }
  .search-link {
    margin-bottom: 10px;
  }
</style>
<title>Home - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<div id="intro">
  BSDB is a database of drug-responsive protein sequences, derived from
  the <a href="http://guidetopharmacology.org" target="_blank">IUPHAR/BPS Guide
  to PHARMACOLOGY</a>.
</div>

<table id="detail_container">

	<tr>

		<td class="col">
			<div class="box">
				<div class="box_title">
					Ligands
				</div>
        <div>
          <div class="entity-description"><a href="">Molecules which interact with a sequence</a></div>
          <table class="datatable">
            <tr><td>Synthetic Organic</td><td><% out.print(ligandTypeCounts[0]); %></td></tr>
            <tr><td>Metabolite</td><td><% out.print(ligandTypeCounts[1]); %></td></tr>
            <tr><td>Natural Product</td><td><% out.print(ligandTypeCounts[2]); %></td></tr>
            <tr><td>Endogenous Peptide</td><td><% out.print(ligandTypeCounts[3]); %></td></tr>
            <tr><td>Other Peptide</td><td><% out.print(ligandTypeCounts[4]); %></td></tr>
            <tr><td>Inorganic</td><td><% out.print(ligandTypeCounts[5]); %></td></tr>
            <tr><td>Antibody</td><td><% out.print(ligandTypeCounts[6]); %></td></tr>
          </table>
          <div class="search-link"><a href="search/ligands">Search ligands...</a></div>
			</div>
		</td>

    <td class="col">
      <div class="box">
				<div class="box_title">
					Sequences
				</div>
        <div>
          <div class="entity-description"><a href="sequences">Sequences which interact with a ligand</a></div>
						<table class="datatable">
							<tr><td>GPCR</td><td><% out.print(sequenceTypeCounts[0]); %></td></tr>
							<tr><td>LGIC</td><td><% out.print(sequenceTypeCounts[1]); %></td></tr>
							<tr><td>VGIC</td><td><% out.print(sequenceTypeCounts[2]); %></td></tr>
							<tr><td>Other Ion Channel</td><td><% out.print(sequenceTypeCounts[3]); %></td></tr>
							<tr><td>NHR</td><td><% out.print(sequenceTypeCounts[4]); %></td></tr>
							<tr><td>Enzyme</td><td><% out.print(sequenceTypeCounts[5]); %></td></tr>
							<tr><td>Catalytic Receptor</td><td><% out.print(sequenceTypeCounts[6]); %></td></tr>
							<tr><td>Transporter</td><td><% out.print(sequenceTypeCounts[7]); %></td></tr>
							<tr><td>Other Protein</td><td><% out.print(sequenceTypeCounts[8]); %></td></tr>
						</table>
          <div class="search-link"><a href="search/ligands">Search sequences...</a></div>
  			</div>
			</div>
		</td>

	</tr>

  <tr>

		<td class="col">
      <div class="box">
				<div class="box_title">
					Useful Links
				</div>
			</div>
		</td>

		<td class="col">
			<div class="box">
				<div class="box_title">
					Guide to PHARMACOLOGY
				</div>
			</div>
		</td>

	</tr>

</table>

<%@include file="/includes/bodybottom.html"%>
