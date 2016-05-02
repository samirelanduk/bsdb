<%@ page import = "org.bsdbmanage.*" %>

<%
	if (Utilities.validMapId(request, "id")) {
		DatabaseAccess.removeInteractionPdb(request.getParameter("id"));
	}
	response.sendRedirect("/manage/interactions.jsp");
%>
