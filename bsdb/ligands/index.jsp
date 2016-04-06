<%@ page import = "org.bsdb.*" %>

<%@include file="/includes/start.html"%>
<title>Ligands - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>All Ligands</h1>
<div id="list_container">

  <div id="list_categories">
    <div class="list_category">All</div>
    <div class="list_category">Approved</div>
    <div class="list_category">Synthetic organic</div>
    <div class="list_category">Metabolite</div>
    <div class="list_category">Natural product</div>
    <div class="list_category">Endogenous peptide</div>
    <div class="list_category">Other peptide</div>
    <div class="list_category">Inorganic</div>
    <div class="list_category">Antibody</div>
  </div>

  <div id="category_description">
		<p>All ligands with an affinity for one or more of the drug-responsive
			elements - both approved and unapproved by a regulatory body ().</p>
	</div>

  <table id="list_table">
		<thead>
			<th>Name</th>
			<th>ID</th>
			<th>Approved</th>
			<th>Type</th>
			<th>Mass</th>
			<th>Synonyms</th>
		</thead>
		<tbody>
      <%
  		String[] rows = Utilities.getLigandRows(Utilities.getAllLigandsAsObjects());
  		for (String row : rows) {
  			out.println(row);
  		}
  		%>
		</tbody>
	</table>

</div>

<%@include file="/includes/bodybottom.html"%>
