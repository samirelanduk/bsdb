<%@ page import = "org.bsdbmanage.*" %>

<%
	FalseMap falseMap;
	if (Utilities.validMapId(request, "id")) {
		falseMap = DatabaseAccess.getFalseMap(request.getParameter("id"));
    if (falseMap == null) {
  		response.sendRedirect("/manage/");
    }
	} else {
		response.sendRedirect("/manage/");
		falseMap = null;
	}
%>

<html>
  <head>
    <title><% out.print(falseMap == null ? "" : falseMap.getMapId()); %></title>
  </head>
  <body>
    <h1><% out.print(falseMap == null ? "" : "Interaction " +
     falseMap.getInteraction().getInteractionId() + " - "
      + falseMap.getPdbCode()); %></h1>

    <div id="back">
      <a href="/manage/interactions.jsp">Back to Interactions</a>
    </div>

    <div id="interaction">
      <table>
        <tr>
          <td>Interaction ID</td>
          <td><% out.print(falseMap == null ? "" : falseMap.getInteraction().getInteractionId()); %></td>
        </tr>
        <tr>
          <td>Ligand ID</td>
          <td><% out.print(falseMap == null ? "" : Utilities.enclose(
           "a",
           String.format(
            "href='http://www.guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=%d' target='_blank'",
            falseMap.getInteraction().getLigandId()
           ),
           "" + falseMap.getInteraction().getLigandId()
          )); %></td>
        </tr>
        <tr>
          <td>Target ID</td>
          <td><% out.print(falseMap == null ? "" : Utilities.enclose(
           "a",
           String.format(
            "href='http://www.guidetopharmacology.org/GRAC/ObjectDisplayForward?objectId=%d' target='_blank'",
            falseMap.getInteraction().getTargetId()
           ),
           "" + falseMap.getInteraction().getTargetId()
          )); %></td>
        </tr>
        <tr>
          <td>Species</td>
          <td><% out.print(falseMap == null ? "" : falseMap.getInteraction().getSpecies()); %></td>
        </tr>
      </table>
    </div>

    <div id="pdb"><% out.print(falseMap == null ? "" : Utilities.enclose(
     "a",
     String.format(
      "href='http://www.rcsb.org/pdb/explore.do?structureId=%s' target='_blank'",
      falseMap.getPdbCode()
     ),
     "" + falseMap.getPdbCode()
    )); %></div>

		<div id="deletion">
			<form method="POST" action="delete_falsemap.jsp">
				<input type="hidden" name="interactionId" value="<% out.print(falseMap == null ? "" : falseMap.getInteractionId()); %>">
				<input type="hidden" name="pdbCode" value="<% out.print(falseMap == null ? "" : falseMap.getPdbCode()); %>">
				<input type="submit" value="Delete Blacklist Mark"></input>
			</form>
		</div>
  </body>
</html>
