<%@ page import = "org.bsdb.*" %>

<%
	Ligand ligand;
	if (Utilities.validParam(request, "id")) {
		try {
			ligand = Utilities.getLigand(Integer.parseInt(request.getParameter("id")));
		} catch (ArrayIndexOutOfBoundsException e) {
			response.sendRedirect("/ligands");
			ligand = new Ligand();
		}
	} else {
		response.sendRedirect("/ligands");
		ligand = new Ligand();
	}
%>

<%@include file="/includes/start.html"%>
<title><% out.print(ligand.getName()); %> - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<div id="detail_container">
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

	<div class="box">
		<div class="box_title">
			Structure
		</div>
		<img src="http://www.guidetopharmacology.org/CHEMSTRUCT/iuphar/<% out.print(ligand.getLigandId()); %>.gif">
	</div>

	<div class="box">
		<div class="box_title">
			Molecular Details
		</div>
		<table>
			<tr>
				<td>Molecular mass (Da)</td>
				<td><% out.print(ligand.getMass()); %></td>
			</tr>
			<tr>
				<td>Hydrogen bond acceptors</td>
				<td><% out.print(ligand.gethBondAcceptors()); %></td>
			</tr>
			<tr>
				<td>Hydrogen bond donors</td>
				<td><% out.print(ligand.gethBondDonors()); %></td>
			</tr>
			<tr>
				<td>Polar surface area (A<sup>2</sup>)</td>
				<td><% out.print(ligand.getSurfaceArea()); %></td>
			</tr>
			<tr>
				<td>Lipinski rules broken</td>
				<td><% out.print(ligand.getLipinksi()); %></td>
			</tr>
			<tr>
				<td>logP</td>
				<td><% out.print(ligand.getLogP()); %></td>
			</tr>
		</table>
	</div>

	<div class="box">
		<div class="box_title">
			Other Details
		</div>
		<table>
			<tr>
				<td>Ligand type</td>
				<td><% out.print(ligand.getType()); %></td>
			</tr>
			<tr>
				<td>Radiolabelled</td>
				<td><% out.print(ligand.isRadioactive() ? "Yes" : "No"); %></td>
			</tr>
			<tr>
				<td>Approved</td>
				<td><% out.print(ligand.isApproved() ? "Yes" : "No"); %></td>
			</tr>
			<tr>
				<td>Approval Source</td>
				<td><% out.print(ligand.getApprovalSource()); %></td>
			</tr>
		</table>
	</div>

	<div class="box">
		<div class="box_title">
			Responsive Sequences
		</div>
		<%
		for (Sequence sequence : Utilities.getLigandSequences(ligand.getLigandId())) {
			out.println(sequence.getConciseHtml());
		}
		%>
	</div>
</div>


<%@include file="/includes/bodybottom.html"%>
