<%@ page import = "org.manage.*" %>

<%
  boolean validInteractionId = true;
  String interactionId = "";
  if ("POST".equals(request.getMethod())) {
    if (Utilities.validInteractionId(request, "interactionId") && DatabaseAccess.interactionExists(Integer.parseInt(request.getParameter("interactionId")))) {
  		DatabaseAccess.addInteractionPdb(Integer.parseInt(request.getParameter("interactionId")), request.getParameter("pdbCode"));
    	response.sendRedirect("/manage/mapinteractions.jsp");
  	} else {
      validInteractionId = false;
      interactionId = request.getParameter("interactionId");
    }
  }

%>

<html>
  <head>
    <title>Add Interaction</title>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" type="text/css" href="/manage/css/map.css">
  </head>
  <body>
    <h1>Add Interaction</h1>
    <div class="error">
      <% out.println(validInteractionId ? "" : String.format("%s is not a valid Interaction ID", interactionId)); %>
    </div>
    <form method="POST" class="pure-form pure-form-aligned">
      <fieldset>
        <div class="pure-control-group">
          <label for="id_interaction">Interaction</label>
          <input type="text" name="interactionId" id="id_interaction">
        </div>
        <div class="pure-control-group">
          <label for="id_pdb">PDB</label>
          <input type="text" name="pdbCode" id="id_pdb">
        </div>
      </fieldset>
      <div class="pure-control-group">
        <label></label>
        <input type="submit" class="pure-button">
      </div>
    </form>
    <p><a href="index.jsp">Back to index</a></p>
  </body>
</html>
