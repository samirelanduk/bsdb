<%@ page import = "org.manage.*" %>

<%
	if (Utilities.validMapId(request, "id")) {
		DatabaseAccess.addHet(
     request.getParameter("id"),
     request.getParameter("het")
    );
		DatabaseAccess.removeSite(request.getParameter("id"));
		DatabaseAccess.removeSequence(request.getParameter("id"));
	}
	response.sendRedirect("/manage/pdbmap.jsp?id=" + request.getParameter("id"));
%>
