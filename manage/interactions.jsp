<%@ page import = "org.bsdbmanage.*" %>
<% Interaction[] interactions = DatabaseAccess.getAllInteractions(); %>
<html>
  <head>
    <title>All Interactions</title>
  </head>
  <body>
    <h1>All Interactions</h1>
    <p>There are <% out.print(interactions.length); %> interactions in the staging database.</p>
    <table>
      <thead>
        <th>Interaction ID</th>
        <th>Ligand ID</th>
        <th>Target ID</th>
        <th>Species</th>
        <th>Date Added</th>
        <th>Date Last Modified</th>
        <th>Last Checked for PDBs</th>
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
