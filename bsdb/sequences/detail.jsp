<%@ page import = "org.bsdb.*" %>

<%
	Sequence sequence;
	if (Utilities.validParam(request, "id")) {
		try {
			sequence = DatabaseAccess.getSequence(Integer.parseInt(request.getParameter("id")));
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

				<!--<img class="fill" src="/static/images/pymol/<% out.print(sequence.getSequenceId()); %>.png">-->
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
							<td class="value"><% out.print(Utilities.floatToPercentage(sequence.getProportionalLength())); %></td>
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
							<td class="value"><% out.print(Utilities.floatToPercentage(sequence.getContactRatio() / 10)); %></td>
						</tr>
					</table>
			</div>
		</td>
	</tr>

	<tr>
		<td class="col" colspan="2">
			<div class="box">
				<div class="box_title">
					Features
				</div>
				<div id="feature"></div>
				<link type="text/css" rel="stylesheet" href="https://cdn.rawgit.com/calipho-sib/feature-viewer/master/css/style.css">
				<script src="/js/feature.js"></script>
				<script>
					var FeatureViewer = require("feature-viewer");

					window.onload = function() {
						var sequence = "<% out.print(sequence.getSequence()); %>";
						var residue_locations = [];
						for (var i = 0; i < sequence.length; i++) {
							if (sequence[i] == sequence[i].toUpperCase()) {
								residue_locations.push({x: i + 1, y: i + 1});
							}
						}
						var hydrophobicity = [];
						for (var i = 0; i < sequence.length; i++) {
							hydrophobicity.push({
								x: i + 1,
								y: {
									'M': 1.9, 'S': -0.8, 'F': 2.8, 'I': 4.5, 'C': 2.5,
									'N': -3.5, 'L': 3.8, 'R': -4.5, 'V': 4.2, 'A': 1.8,
									'Q': -3.5, 'G': -0.4, 'W': -0.9, 'K': -3.9, 'D': -3.5,
									'T': -0.7, 'H': -3.2, 'E': -3.5, 'P': -1.6, 'Y': -1.3
								}[sequence[i].toUpperCase()]
							})
						}

						var ft2 = new FeatureViewer(sequence,"#feature", {
								showAxis: true,
								showSequence: true,
								brushActive: true,
								toolbar:true,
								bubbleHelp:true,
								zoomMax:10
												});

						ft2.addFeature({
				        data: residue_locations,
				        name: "Binding residues",
				        color: "#006588",
				        type: "rect",
				        height: "20",
								filter: "type1"
				    });

						ft2.addFeature({
			        data: hydrophobicity,
			        name: "Hydropathy",
			        color: "#008B8D",
			        type: "line",
			        height: "5",
							filter: "type2"
			    });

						ft2.onAll(function(name,data){
							console.log(arguments);
						});
					};
				</script>
			</div>
		</td>
	</tr>

	<!--<tr>
		<td class="col" colspan="2">
			<div class="box">
				<div class="box_title">
					Residue Distances
				</div>
				<iframe seamless='seamless' width="750px" height="750px" src="/static/svg/<% out.print(sequence.getSequenceId()); %>.html"></iframe>
			</div>
		</td>
	</tr>-->
</table>


<%@include file="/includes/bodybottom.html"%>
