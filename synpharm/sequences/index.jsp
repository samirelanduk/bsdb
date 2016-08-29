<%@ page import = "org.synpharm.*" %>

<%@include file="/includes/start.html"%>
<link rel="stylesheet" type="text/css" href="/css/list.css">
<title>Sequences - BindSequenceDB</title>
<script src="/js/sequences.js"></script>
<script src="/js/list.js"></script>
<script src="/js/listsort.js"></script>
<%@include file="/includes/bodytop.html"%>

<h1>All Drug Responsive Sequences</h1>
<div id="list_container">

  <div id="category_container">
    <div id="list_categories">
      <div class="list_category selected" onclick="selectRows(0)">All</div>
      <div class="list_category" onclick="selectRows(1)">Approved drugs</div>
      <div class="list_category" onclick="selectRows(2)">Short</div>
      <div class="list_category" onclick="selectRows(3)">Long</div>
      <div class="list_category" onclick="selectRows(4)">Human</div>
      <div class="list_category" onclick="selectRows(5)">Non-Human</div>
      <div class="list_category" onclick="selectRows(6)">Small proportional length</div>
    </div>
  </div>

  <div id="category_description">
		<p>All drug-responsive elements which respond to a Guide to PHARMACOLOGY ligand ().</p>
	</div>

  <table id="list_table">
		<thead>
			<th onclick="sortColumn(0,true)" class="A">ID</th>
      <th onclick="sortColumn(1,true)" class="N">Target</th>
			<th onclick="sortColumn(2,true)" class="N">Species</th>
			<th onclick="sortColumn(3,true)" class="N">Ligand</th>
			<th onclick="sortColumn(4,true)" class="N expendable">Length</th>
			<th onclick="sortColumn(5,true)" class="N expendable">Proportional length</th>
		</thead>
		<tbody>
      <%
  		String[] rows = DatabaseAccess.getSequenceRows();
  		for (String row : rows) {
  			out.println(row);
  		}
  		%>
		</tbody>
	</table>

</div>

<script>selectRows(0); colorRows();</script>
<%@include file="/includes/bodybottom.html"%>
