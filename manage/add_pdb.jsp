<%@ page import = "org.manage.*" %>

<%
	if (Utilities.validInteractionId(request, "interactionId") && Utilities.validPdbCode(request, "pdbCode")) {
		DatabaseAccess.addInteractionPdb(Integer.parseInt(request.getParameter("interactionId")), request.getParameter("pdbCode"));
	}
	response.sendRedirect("/manage/mapinteractions.jsp");
%>
