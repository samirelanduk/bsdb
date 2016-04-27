<%@ page import = "org.bsdbmanage.*" %>

<%
	InteractionPdb interactionPdb;
	if (Utilities.validMapId(request, "id")) {
		interactionPdb = DatabaseAccess.getInteractionPdb(request.getParameter("id"));
    if (interactionPdb == null) {
  		response.sendRedirect("/manage/");
    }
	} else {
		response.sendRedirect("/manage/");
		interactionPdb = null;
	}
%>

<html>
  <head>
    <title><% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %></title>
  </head>
  <body>
  </body>
</html>
