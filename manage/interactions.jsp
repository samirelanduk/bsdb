<%@ page import = "org.bsdbmanage.*" %>
<html>
  <head>
    <title>All Interactions</title>
  </head>
  <body>
    <h1>All Interactions</h1>
    <table>
      <thead>
        <th>Interaction ID</th>
        <th>Ligand ID</th>
        <th>Target ID</th>
        <th>Species</th>
        <th>Date Added</th>
        <th>Date Last Modified</th>
      </thead>
      <tbody>
        <%
        Interaction[] interactions = DatabaseAccess.getAllInteractions();
        for (Interaction interaction : interactions) {
          out.println(interaction.toHtmlRow());
        }
        %>
      </tbody>
    </table>
  </body>
</html>
