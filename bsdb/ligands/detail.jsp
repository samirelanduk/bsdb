<%@ page import = "org.bsdb.*" %>

<%
	Ligand ligand;
	if (Utilities.validParam(request, "id")) {
		ligand = DatabaseAccess.getLigand(
		 Integer.parseInt(request.getParameter("id"))
		);
	} else {
		response.sendRedirect("/ligands");
		ligand = new Ligand();
	}
%>

<%@include file="/includes/start.html"%>
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<title><% out.print(ligand.getName()); %> - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<table id="detail_container">

	<tr>

		<td class="col">
			<div id="ligand_title">
				<h1><% out.print(ligand.getName()); %></h1>
				<div id="gtop_link">
					<a href= "http://www.guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=<% out.print(ligand.getLigandId()); %>">
						Guide to PHARMACOLOGY ID: <% out.print(ligand.getLigandId()); %>
					</a>
				</div>
				<%
				for (LigandLink link : ligand.getExternalLinks()) {
					out.println(link.getHtml());
				}
				%>
			</div>
		</td>

		<td class="col">
			<div class="box">
				<div class="box_title">
					Structure
				</div>
				<img src="http://www.guidetopharmacology.org/CHEMSTRUCT/iuphar/<% out.print(ligand.getLigandId()); %>.gif">
			</div>
		</td>

	</tr>

	<tr>
		<td class="col">
			<div class="box">
				<div class="box_title">
					Molecular Details
				</div>
				<table>
					<tr>
						<td class="field">Molecular mass (Da)</td>
						<td class="value"><% out.print(ligand.getMass()); %></td>
					</tr>
					<tr>
						<td class="field">Hydrogen bond acceptors</td>
						<td class="value"><% out.print(ligand.gethBondAcceptors()); %></td>
					</tr>
					<tr>
						<td class="field">Hydrogen bond donors</td>
						<td class="value"><% out.print(ligand.gethBondDonors()); %></td>
					</tr>
					<tr>
						<td class="field">Polar surface area (A<sup>2</sup>)</td>
						<td class="value"><% out.print(ligand.getSurfaceArea()); %></td>
					</tr>
					<tr>
						<td class="field">Lipinski rules broken</td>
						<td class="value"><% out.print(ligand.getLipinksi()); %></td>
					</tr>
					<tr>
						<td class="field">logP</td>
						<td class="value"><% out.print(ligand.getLogP()); %></td>
					</tr>
				</table>
			</div>
		</td>

		<td class="col">
			<div class="box">
				<div class="box_title">
					Other Details
				</div>
				<table>
					<tr>
						<td class="field">Ligand type</td>
						<td class="value"><% out.print(ligand.getType()); %></td>
					</tr>
					<tr>
						<td class="field">Radiolabelled</td>
						<td class="value"><% out.print(ligand.isRadioactive() ? "Yes" : "No"); %></td>
					</tr>
					<tr>
						<td class="field">Approved</td>
						<td class="value"><% out.print(ligand.isApproved() ? "Yes" : "No"); %></td>
					</tr>
					<tr>
						<td class="field">Approval Source</td>
						<td class="value"><% out.print(ligand.getApprovalSource()); %></td>
					</tr>
				</table>
			</div>
		</td>
	</tr>

	<tr>
		<td class="col" colspan="2">
			<div class="box">
				<div class="box_title">
					Responsive Sequences
				</div>
				<%
				for (Sequence sequence : DatabaseAccess.getLigandSequences(ligand.getLigandId())) {
					out.println(sequence.getConciseHtml());
				}
				%>
			</div>
		</td>
	</tr>
</table>


<%@include file="/includes/bodybottom.html"%>
