<%@ page import = "org.bsdb.*" %>

<%
	Sequence sequence;
	if (Utilities.validParam(request, "id")) {
		try {
			sequence = Utilities.getSequence(Integer.parseInt(request.getParameter("id")));
		} catch (ArrayIndexOutOfBoundsException e) {
			response.sendRedirect("/sequences");
			sequence = new Sequence();
		}
	} else {
		response.sendRedirect("/sequences");
		sequence = new Sequence();
	}
%>

<%@include file="/includes/start.html"%>
<title><%
 out.print(sequence.getSpecies() + " " + Utilities.stripHtml(sequence.getTarget().getName()));
%> - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<div id="detail_container">
	<div id="sequence_title">
		<h1><% out.print(sequence.getSpecies() + " " + sequence.getTarget().getName()); %></h1>
		<div id="ligand_link">
			with <a href="/ligands/detail.jsp?id=<% out.print(sequence.getLigand().getLigandId()); %>"><% out.print(sequence.getLigand().getName()); %></a>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Structure
		</div>
		<img src="/static/images/pymol/<% out.print(sequence.getInteractionId()); %>.png">
	</div>

	<div class="box">
		<div class="box_title">
			Sequence
		</div>
		<div id="sequence">
			<% out.println(sequence.getSequenceHtml()); %>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			PDB Details
		</div>
		<table>
				<tr>
					<td>PDB code</td>
					<td><% out.print(sequence.getPdb()); %></td>
				</tr>
				<tr>
					<td>HET name</td>
					<td><% out.print(sequence.getHetName()); %></td>
				</tr>
				<tr>
					<td>HET ID</td>
					<td><% out.print(sequence.getHetId()); %></td>
				</tr>
				<tr>
					<td>Chain</td>
					<td><% out.print(sequence.getChain()); %></td>
				</tr>
			</table>
	</div>

	<div class="box">
		<div class="box_title">
			Other Details
		</div>
		<table>
				<tr>
					<td>Affinity</td>
					<td><% out.print(sequence.getAffinity()); %></td>
				</tr>
				<tr>
					<td>Affinity type</td>
					<td><% out.print(sequence.getAffinityType()); %></td>
				</tr>
				<tr>
					<td>Sequence length</td>
					<td><% out.print(sequence.getSequence().length()); %></td>
				</tr>
				<tr>
					<td>Proportion of original chain length</td>
					<td><% out.print(Utilities.divideToPercentage(sequence.getSequence().length(), sequence.getOriginalChainLength())); %></td>
				</tr>
				<tr>
					<td>Internal contacts</td>
					<td><% out.print(sequence.getInternalContacts()); %></td>
				</tr>
				<tr>
					<td>External contacts</td>
					<td><% out.print(sequence.getExternalContacts()); %></td>
				</tr>
				<tr>
					<td>Contact ratio</td>
					<td><% out.print(Utilities.divideToPercentage(sequence.getExternalContacts(), sequence.getInternalContacts())); %></td>
				</tr>
			</table>
	</div>

	<div class="box">
		<div class="box_title">
			Residue Distances
		</div>
		<iframe seamless='seamless' width="750px" height="750px" src="/static/svg/<% out.print(sequence.getInteractionId()); %>.html"></iframe>
	</div>
</div>


<%@include file="/includes/bodybottom.html"%>
