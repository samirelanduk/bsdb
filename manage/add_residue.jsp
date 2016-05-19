<%@ page import = "org.bsdbmanage.*" %>

<%
	if (Utilities.validMapId(request, "id")) {
		DatabaseAccess.addMapResidue(
     request.getParameter("id"),
     request.getParameter("residue")
    );
	}
	response.sendRedirect("/manage/pdbmap.jsp?id=" + request.getParameter("id"));
%>
