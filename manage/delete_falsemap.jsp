<%@ page import = "org.bsdbmanage.*" %>

<%
	if (Utilities.validInteractionId(request, "interactionId") && Utilities.validPdbCode(request, "pdbCode")) {
		DatabaseAccess.removeFalseMap(Integer.parseInt(request.getParameter("interactionId")), request.getParameter("pdbCode"));
	}
	response.sendRedirect("/manage/interactions.jsp");
%>
