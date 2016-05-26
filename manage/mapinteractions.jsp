<%@ page import = "org.bsdbmanage.*" %>
<% Interaction[] interactions = DatabaseAccess.getMapInteractions(); %>
<html>
  <head>
    <title>Interactions with PDB Maps</title>
    <link rel="stylesheet" type="text/css" href="/manage/css/list.css">
  </head>
  <body>
    <h1>Interactions with PDB Maps</h1>
    <p><a href="index.jsp">Back to index</a></p>
    <p>There are <% out.print(interactions.length); %> interactions with PDBs in the staging database.</p>
    <table>
      <thead>
        <th>Interaction ID</th>
        <th>Ligand ID</th>
        <th>Target ID</th>
        <th>Species</th>
        <th>Type</th>
        <th>Action</th>
        <th>Affinity Type</th>
        <th>Affinity</th>
        <th>Affinity Range</th>
        <th>Peptide Ligand</th>
        <th>Date Added</th>
        <th>Last Modified</th>
        <th>Last PDB Check</th>
        <th>PDBs</th>
        <th>Blacklisted PDBs</th>
      </thead>
      <tbody>
        <%
        for (Interaction interaction : interactions) {
          out.println(interaction.toHtmlRow());
        }
        %>
      </tbody>
    </table>
  </body>
</html>
