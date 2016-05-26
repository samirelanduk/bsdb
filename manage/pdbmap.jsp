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
    <link rel="stylesheet" type="text/css" href="/manage/css/map.css">
  </head>
  <body>
    <h1>Map: <% out.print(interactionPdb == null ? "" : "Interaction " +
     interactionPdb.getInteractionId() + " - "
      + interactionPdb.getPdbCode()); %></h1>

    <div id="back">
      <a href="/manage/mapinteractions.jsp">Back to Interactions</a>
    </div>

    <div class="section" id="interaction">
			<h2>Interaction <% out.print(interactionPdb == null ? "" : interactionPdb.getInteractionId()); %></h2>
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

    <div class="section" id="pdb"><h2>PDB Link</h2><% out.print(interactionPdb == null ? "" : Utilities.enclose(
     "a",
     String.format(
      "href='http://www.rcsb.org/pdb/explore.do?structureId=%s' target='_blank'",
      interactionPdb.getPdbCode()
     ),
     "" + interactionPdb.getPdbCode()
    )); %></div>

		<div class="section" id="manual">
			<h2>Manual Verification</h2>
			<p>This map <strong>has
				<% out.print((interactionPdb == null || !(interactionPdb.isManuallyMarkedCorrect())) ? "not" : ""); %>
			</strong>been manually marked as a correct map.</p>
      <form method="POST" action="toggle_correct.jsp">
        <input type="hidden" name="id" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %>">
        <p>This map <strong>was
          <% out.print((interactionPdb == null || !(interactionPdb.isManuallyAdded())) ? "not" : ""); %>
        </strong>manually added.</p>
        <input type="submit" value="Toggle Correctness"></input>
      </form>
    </div>

		<div class="section" id="deletion">
			<h2>Deletion</h2>
			<form method="POST" action="delete_pdb.jsp">
				<label for="blacklist">Blacklist?</label><input type="checkbox" id="blacklist" name="blacklist" value="yes">
				<input type="hidden" name="interactionId" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getInteractionId()); %>">
				<input type="hidden" name="pdbCode" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getPdbCode()); %>">
				<input type="submit" value="Delete Map"></input>
			</form>
		</div>

		<div class="section" id="het">
			<h2>Ligand in PDB</h2>
			<p><% out.print((interactionPdb == null || interactionPdb.getHet() == null) ?
			  "-" : interactionPdb.getHet()); %></p>
			<form method="POST" action="edit_het.jsp">
				<input type="input" id="het" name="het" placeholder="Specify ligand ID...">
				<input type="hidden" name="id" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %>">
			</form>
		</div>

		<div class="section" id="bindsite">
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

		<div class="section" id="bindsequence">
			<h2>Bind Sequence and Properties</h2>
			<form method="POST" action="delete_sequence.jsp">
				<input type="hidden" name="id" value="<% out.print(interactionPdb == null ? "" : interactionPdb.getMapId()); %>">
				<input type="submit">
			</form>
			<table>
				<tr>
					<td>Sequence</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getBindSequence() == null) ?
					  "-" : interactionPdb.getBindSequence()); %></td>
				</tr>
				<tr>
					<td>Chain</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getReceptorChain() == null) ?
					  "-" : interactionPdb.getReceptorChain()); %></td>
				</tr>
				<tr>
					<td>Original Chain Length</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getOriginalChainLength() == 0) ?
					  "-" : interactionPdb.getOriginalChainLength()); %></td>
				</tr>
				<tr>
					<td>Length Ratio</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getProportionalLength() == 0) ?
					  "-" : interactionPdb.getProportionalLength()); %></td>
				</tr>
				<tr>
					<td>Internal Contacts</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getInternalContacts() == 0) ?
					  "-" : interactionPdb.getInternalContacts()); %></td>
				</tr>
				<tr>
					<td>External Contacts</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getExternalContacts() == 0) ?
					  "-" : interactionPdb.getExternalContacts()); %></td>
				</tr>
				<tr>
					<td>Contact Ratio</td>
					<td><% out.print((interactionPdb == null || interactionPdb.getContactRatio() == 0) ?
					  "-" : interactionPdb.getContactRatio()); %></td>
				</tr>
			</table>
		</div>
  </body>
</html>
