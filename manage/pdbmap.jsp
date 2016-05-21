<%@ page import = "org.bsdbmanage.*" %>

<%
	InteractionPdb interactionPdb;
	Interaction interaction;
	if (Utilities.validMapId(request, "id")) {
		interactionPdb = DatabaseAccess.getInteractionPdb(request.getParameter("id"));
    if (interactionPdb == null) {
  		response.sendRedirect("/manage/");
			interaction = null;
    } else {
			interaction = interactionPdb.getInteraction();
		}
	} else {
		response.sendRedirect("/manage/");
		interactionPdb = null;
		interaction = null;
	}
%>

<html>
  <head>
    <title><% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %></title>
  </head>
  <body>
    <h1><% out.print(interactionPdb == null ? "" : "Interaction " +
     interactionPdb.getInteractionId() + " - "
      + interactionPdb.getPdbCode()); %></h1>

    <div id="back">
      <a href="/manage/interactions.jsp">Back to Interactions</a>
    </div>

    <div id="interaction">
      <table>
        <tr>
          <td>Interaction ID</td>
          <td><% out.print(interactionPdb == null ? "" : interactionPdb.getInteractionId()); %></td>
        </tr>
        <tr>
          <td>Ligand ID</td>
          <td><% out.print(interactionPdb == null ? "" : Utilities.enclose(
           "a",
           String.format(
            "href='http://www.guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=%d' target='_blank'",
            interaction.getLigandId()
           ),
           "" + interaction.getLigandId()
          )); %></td>
        </tr>
        <tr>
          <td>Target ID</td>
          <td><% out.print(interactionPdb == null ? "" : Utilities.enclose(
           "a",
           String.format(
            "href='http://www.guidetopharmacology.org/GRAC/ObjectDisplayForward?objectId=%d' target='_blank'",
            interaction.getTargetId()
           ),
           "" + interaction.getTargetId()
          )); %></td>
        </tr>
        <tr>
          <td>Species</td>
          <td><% out.print(interactionPdb == null ? "" : interaction.getSpecies()); %></td>
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

		<div id="het">
			<h2>Ligand in PDB</h2>
			<p><% out.print((interactionPdb == null || interactionPdb.getHet() == null) ?
			  "-" : interactionPdb.getHet()); %></p>
			<form method="POST" action="edit_het.jsp">
				<input type="input" id="het" name="het">
				<input type="hidden" name="id" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %>">
			</form>
		</div>

		<div id="bindsite">
			<h2>BindSite in PDB</h2>
			<p><% if (interactionPdb == null || interactionPdb.getBindingResidues() == null) {
					out.println("-");
				} else {
					for (String residue : interactionPdb.getBindingResidues()) {
						if (residue.length() > 1) {
							out.print(residue +
							 "<form method='POST' action='delete_residue.jsp'><input type='hidden' name='residue' value='" + residue + "'><input type='hidden' name='id' value='" + interactionPdb.getMapId() + "'><input type='submit'></form> "
							);
						}
					}
				} %></p>
			<form method="POST" action="add_residue.jsp">
				<input type="input" id="residue" name="residue">
				<input type="hidden" name="id" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %>">
			</form>
		</div>

		<div id="bindsequence">
			<h2>Bind Sequence and Properties</h2>
			<table>
				<tr>
					<td>Sequence</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getBindSequence() == null) ?
					  "-" : interactionPdb.getBindSequence()); %></td>
				</tr>
			</table>
		</div>
  </body>
</html>
