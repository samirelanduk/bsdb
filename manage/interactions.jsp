<%@ page import = "org.bsdbmanage.*" %>
<html>
  <head>
    <title>All Interactions</title>
  </head>
  <body>
    <h1>All Interactions</h1>
    <%
    Interaction[] interactions = DatabaseAccess.getAllInteractions();
    out.println(String.format("There are %d interactions.", interactions.length));
    for (Interaction interaction : interactions) {
      out.println(interaction.getSpecies());
    }
    %>
  </body>
</html>
