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
    <h1><% out.print(interactionPdb == null ? "" : "Interaction " +
     interactionPdb.getInteraction().getInteractionId() + " - "
      + interactionPdb.getPdbCode()); %></h1>

    <div id="back">
      <a href="/manage/interactions.jsp">Back to Interactions</a>
    </div>

    <div id="interaction">
      <table>
        <tr>
          <td>Interaction ID</td>
          <td><% out.print(interactionPdb == null ? "" : interactionPdb.getInteraction().getInteractionId()); %></td>
        </tr>
        <tr>
          <td>Ligand ID</td>
          <td><% out.print(interactionPdb == null ? "" : Utilities.enclose(
           "a",
           String.format(
            "href='http://www.guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=%d' target='_blank'",
            interactionPdb.getInteraction().getLigandId()
           ),
           "" + interactionPdb.getInteraction().getLigandId()
          )); %></td>
        </tr>
        <tr>
          <td>Target ID</td>
          <td><% out.print(interactionPdb == null ? "" : Utilities.enclose(
           "a",
           String.format(
            "href='http://www.guidetopharmacology.org/GRAC/ObjectDisplayForward?objectId=%d' target='_blank'",
            interactionPdb.getInteraction().getTargetId()
           ),
           "" + interactionPdb.getInteraction().getTargetId()
          )); %></td>
        </tr>
        <tr>
          <td>Species</td>
          <td><% out.print(interactionPdb == null ? "" : interactionPdb.getInteraction().getSpecies()); %></td>
        </tr>
      </table>
    </div>

    <div id="pdb"><% out.print(interactionPdb == null ? "" : Utilities.enclose(
     "a",
     String.format(
      "href='http://www.rcsb.org/pdb/explore.do?structureId=%s' target='_blank'",
      interactionPdb.getPdbCode()
     ),
     "" + interactionPdb.getPdbCode()
    )); %></div>

		<div id="manual_addition">
			<p>This map has <strong>
				<% out.print((interactionPdb == null || !(interactionPdb.isManuallyMarkedCorrect())) ? "not" : ""); %>
			</strong>been manually marked as a correct map.</p>
		</div>

    <div id="manual_verification">
      <form method="POST" action="toggle_correct.jsp">
        <input type="hidden" name="id" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %>">
        <p>This map has <strong>
          <% out.print((interactionPdb == null || !(interactionPdb.isManuallyAdded())) ? "not" : ""); %>
        </strong>been manually added.</p>
        <input type="submit">Toggle Correctness</input>
      </form>
    </div>

		<div id="deletion">
			<form method="POST" action="delete_pdb.jsp">
				<label for="blacklist">Blacklist?</label><input type="checkbox" id="blacklist" name="blacklist" value="yes">
				<input type="hidden" name="interactionId" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getInteractionId()); %>">
				<input type="hidden" name="pdbCode" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getPdbCode()); %>">
				<input type="submit" value="Delete Map"></input>
			</form>
		</div>
  </body>
</html>
