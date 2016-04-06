<%@ page import = "org.bsdb.*" %>

<%@include file="/includes/start.html"%>
<title>Sequences - BindSequenceDB</title>
<script src="/js/sequences.js"></script>
<script src="/js/list.js"></script>
<%@include file="/includes/bodytop.html"%>

<h1>All Drug Responsive Sequences</h1>
<div id="list_container">

  <div id="list_categories">
    <div class="list_category selected" onclick="selectRows(0)">All</div>
    <div class="list_category" onclick="selectRows(1)">Approved drugs</div>
    <div class="list_category" onclick="selectRows(2)">Short</div>
    <div class="list_category" onclick="selectRows(3)">Long</div>
    <div class="list_category" onclick="selectRows(4)">Hydrophobic</div>
    <div class="list_category" onclick="selectRows(5)">Hydrophilic</div>
    <div class="list_category" onclick="selectRows(6)">Small proportional length</div>
  </div>

  <div id="category_description">
		<p>All drug-responsive elements which respond to a Guide to PHARMACOLOGY ligand ().</p>
	</div>

  <table id="list_table">
		<thead>
			<th onclick="sortColumn(0)" class="A">ID</th>
      <th onclick="sortColumn(1)" class="N">Target</th>
			<th onclick="sortColumn(2)" class="N">Species</th>
			<th onclick="sortColumn(3)" class="N">Ligand</th>
			<th onclick="sortColumn(4)" class="N">Length</th>
			<th onclick="sortColumn(5)" class="N">Proportional length</th>
		</thead>
		<tbody>
      <%
  		String[] rows = Utilities.getSequenceRows(Utilities.getAllSequencesAsObjects());
  		for (String row : rows) {
  			out.println(row);
  		}
  		%>
		</tbody>
	</table>

</div>

<%@include file="/includes/bodybottom.html"%>
