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
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<title><%
 out.print(sequence.getSpecies() + " " + Utilities.stripHtml(sequence.getTarget().getName()));
%> - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<table id="detail_container">
	<tr>
		<td class="col">
			<div id="sequence_title">
				<h1><% out.print(sequence.getSpecies() + " " + sequence.getTarget().getName()); %></h1>
				<div id="ligand_link">
					with <a href="/ligands/detail.jsp?id=<% out.print(sequence.getLigand().getLigandId()); %>"><% out.print(sequence.getLigand().getName()); %></a>
				</div>
			</div>
		</td>

		<td class="col">
			<div class="box">
				<div class="box_title">
					Structure
				</div>
				<img class="fill" src="/static/images/pymol/<% out.print(sequence.getInteractionId()); %>.png">
			</div>
		</td>
	</tr>

	<tr>
		<td class="col" colspan="2">
			<div class="box">
				<div class="box_title">
					Sequence
				</div>
				<div id="sequence">
					<% out.println(sequence.getSequenceHtml()); %>
				</div>
			</div>
		</td>
	</tr>


	<tr>
		<td class="col">
			<div class="box">
				<div class="box_title">
					PDB Details
				</div>
				<table>
						<tr>
							<td class="field">PDB code</td>
							<td class="value"><% out.print(sequence.getPdb()); %></td>
						</tr>
						<tr>
							<td class="field">HET name</td>
							<td class="value"><% out.print(sequence.getHetName()); %></td>
						</tr>
						<tr>
							<td class="field">HET ID</td>
							<td class="value"><% out.print(sequence.getHetId()); %></td>
						</tr>
						<tr>
							<td class="field">Chain</td>
							<td class="value"><% out.print(sequence.getChain()); %></td>
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
							<td class="field">Affinity</td>
							<td class="value"><% out.print(sequence.getAffinity()); %></td>
						</tr>
						<tr>
							<td class="field">Affinity type</td>
							<td class="value"><% out.print(sequence.getAffinityType()); %></td>
						</tr>
						<tr>
							<td class="field">Sequence length</td>
							<td class="value"><% out.print(sequence.getSequence().length()); %></td>
						</tr>
						<tr>
							<td class="field">Proportion of original chain length</td>
							<td class="value"><% out.print(Utilities.divideToPercentage(sequence.getSequence().length(), sequence.getOriginalChainLength())); %></td>
						</tr>
						<tr>
							<td class="field">Internal contacts</td>
							<td class="value"><% out.print(sequence.getInternalContacts()); %></td>
						</tr>
						<tr>
							<td class="field">External contacts</td>
							<td class="value"><% out.print(sequence.getExternalContacts()); %></td>
						</tr>
						<tr>
							<td class="field">Contact ratio</td>
							<td class="value"><% out.print(Utilities.divideToPercentage(sequence.getExternalContacts(), sequence.getInternalContacts())); %></td>
						</tr>
					</table>
			</div>
		</td>
	</tr>

	<tr>
		<td class="col" colspan="2">
			<div class="box">
				<div class="box_title">
					Residue Distances
				</div>
				<iframe seamless='seamless' width="750px" height="750px" src="/static/svg/<% out.print(sequence.getInteractionId()); %>.html"></iframe>
			</div>
		</td>
	</tr>
</table>


<%@include file="/includes/bodybottom.html"%>
