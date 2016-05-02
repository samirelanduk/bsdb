<%@ page import = "org.bsdbmanage.*" %>

<%
	if (Utilities.validInteractionId(request, "interactionId") && Utilities.validPdbCode(request, "pdbCode")) {
		DatabaseAccess.addInteractionPdb(Integer.parseInt(request.getParameter("interactionId")), request.getParameter("pdbCode"));
	}
  out.println(request.getParameter("interactionId"));
  out.println(request.getParameter("pdbCode"));
	//response.sendRedirect("/manage/interactions.jsp");
%>
