<%@ page import = "org.bsdbmanage.*" %>

<%
	if (Utilities.validInteractionId(request, "interactionId") && Utilities.validPdbCode(request, "pdbCode")) {
    if (request.getParameter("blacklist") != null) {
      DatabaseAccess.blacklistMap(Integer.parseInt(request.getParameter("interactionId")), request.getParameter("interactionId"));
    }
		DatabaseAccess.removeInteractionPdb(Integer.parseInt(request.getParameter("interactionId")), request.getParameter("pdbCode"));
	}
	response.sendRedirect("/manage/interactions.jsp");
%>
