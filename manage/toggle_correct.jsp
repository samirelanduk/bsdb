<%@ page import = "org.manage.*" %>

<%
	if (Utilities.validMapId(request, "id")) {
		DatabaseAccess.toggleInteractionPdbManualCorrectnessMark(request.getParameter("id"));
	}
	response.sendRedirect("/manage/pdbmap.jsp?id=" + request.getParameter("id"));
%>
