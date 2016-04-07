<%@ page import = "org.bsdb.*" %>

<%@include file="/includes/start.html"%>
<link rel="stylesheet" type="text/css" href="/css/list.css">
<title>Ligands - BindSequenceDB</title>
<script src="/js/ligands.js"></script>
<script src="/js/list.js"></script>
<%@include file="/includes/bodytop.html"%>

<h1>All Ligands</h1>
<div id="list_container">

  <div id="list_categories">
    <div class="list_category selected" onclick="selectRows(0)">All</div>
    <div class="list_category" onclick="selectRows(1)">Approved</div>
    <div class="list_category" onclick="selectRows(2)">Synthetic organic</div>
    <div class="list_category" onclick="selectRows(3)">Metabolite</div>
    <div class="list_category" onclick="selectRows(4)">Natural product</div>
    <div class="list_category" onclick="selectRows(5)">Endogenous peptide</div>
    <div class="list_category" onclick="selectRows(6)">Other peptide</div>
    <div class="list_category" onclick="selectRows(7)">Inorganic</div>
    <div class="list_category" onclick="selectRows(8)">Antibody</div>
  </div>

  <div id="category_description">
		<p>All ligands with an affinity for one or more of the drug-responsive
			elements - both approved and unapproved by a regulatory body ().</p>
	</div>

  <table id="list_table">
		<thead>
			<th onclick="sortColumn(0)" class="N">Name</th>
			<th onclick="sortColumn(1)" class="A">ID</th>
			<th onclick="sortColumn(2)" class="N">Approved</th>
			<th onclick="sortColumn(3)" class="N">Type</th>
			<th onclick="sortColumn(4)" class="N">Mass</th>
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
