<%@ page import = "org.synpharm.*" %>

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
 out.print(sequence.getSpecies() + " " + Utilities.stripHtml(sequence.getTargetNameStripped()));
%> - SynPharm</title>
<script src="/js/sequence-manipulation.js"></script>
<%@include file="/includes/bodytop.html"%>

<div id="box_container">
	<div class="cell">
		<div id="sequence_title">
			<h1><% out.print(sequence.getSpecies() + " " + sequence.getTargetName()); %></h1>
			<div id="ligand_link">
				with <a href="/ligands/detail.jsp?id=<% out.print(sequence.getLigand().getLigandId()); %>"><% out.print(sequence.getLigand().getName()); %></a>
			</div>
			<div id="ligand_link">
				GtoP Target: <a href="http://guidetopharmacology.org/GRAC/ObjectDisplayForward?objectId=<% out.print(sequence.getTargetId()); %>"><% out.print(sequence.getTargetName()); %></a>
			</div>
		</div>
	</div>

	<div class="cell">
		<div class="box" id="pv-box">
			<div class="box_title">
				Structure
			</div>
			<div id="viewer"></div>
			<script type="text/javascript" src="/js/pv.min.js"></script>
			<script type="text/javascript">
				var options = {
				 width: "auto",
				 height: 390,
				 antialias: true,
				 quality : "high",
				 background: "#ffffff"
				};
				var viewer = pv.Viewer(document.getElementById("viewer"), options);
			</script>
			<script type="text/javascript">
				function loadStructure() {
					pv.io.fetchPdb("/static/pdbs/<% out.print(sequence.getSequenceId()); %>.pdb", function(structure) {
						var ligandId = "<% out.print(sequence.getHetId()); %>";
						var ligandObjects = [];
						if (ligandId.length == 1) {
							// The ligand is a chain
							ligandObjects.push(structure.select({chain:ligandId}));
						} else if (ligandId.indexOf(",") > -1) {
							// The ligand is multiple chains
							var ligandIds = ligandId.split(",");
							for (var l = 0; l < ligandIds.length; l++) {
								ligandObjects.push(structure.select({chain:ligandIds[l]}));
							}
						}	else {
							// The ligand is an ordinary molecule
							ligandObjects.push(structure.select({rnum : parseInt("<% out.print(sequence.getHetId()); %>".replace(/\D/g,''))}));
						}
						var chains = structure.chains();
						for (var c = 0; c < chains.length; c++) {
							if ((chains[c].name() != ligandId) && (ligandId.split(",").indexOf(chains[c].name()) == -1)) {
								viewer.cartoon("chain", structure.select({chain:chains[c].name()}), {color: pv.color.uniform("white")});
							}
						}
						for (var l = 0; l < ligandObjects.length; l++) {
							viewer.spheres("ligand", ligandObjects[l]);
						}

						var residueIds = ["<% out.print(sequence.getResidueIds().replace(",", "\",\"")); %>"];
						var bindingIds = ["<% out.print(sequence.getBindingResidues().replace(",", "\",\"")); %>"];
                        var bindingResidueIds = []
						for (var i = 0; i < bindingIds.length; i++) {
                            bindingResidueIds.push(parseInt(bindingIds[i].replace(/\D/g,'')))
                        }
                        viewer.ballsAndSticks("ligand", structure.select({chain:"A", rnums:bindingResidueIds}));

						var sequenceIds = [];
						for (var i = 0; i < residueIds.length; i++) {
							sequenceIds.push(parseInt(residueIds[i].replace(/\D/g,'')))
						}
						viewer.forEach(function(object) {
						  object.setOpacity(0.8);
							object.setOpacity(1, object.select({chain:"<% out.print(sequence.getChain()); %>"}));
							if (ligandId.length == 1) {
								object.setOpacity(1, object.select({chain:ligandId}));
							} else if (ligandId.indexOf(",") > -1) {
								var ligandIds = ligandId.split(",");
								for (var l = 0; l < ligandIds.length; l++) {
									object.setOpacity(1, object.select({chain:ligandIds[l]}));
								}
							}
							object.colorBy(color.uniform("#34944D"), object.select({chain:"<% out.print(sequence.getChain()); %>", rnums:sequenceIds}));
							object.setOpacity(0, object.select("water"));

							object.colorBy(color.uniform("#660066"), object.select({chain:"A", rnums:bindingResidueIds}));
						});

						viewer.centerOn(structure);
						viewer.autoZoom();
						viewer.setZoom(100);
					});
				}
				document.addEventListener("DOMContentLoaded", loadStructure);
			</script>
		</div>
	</div>

	<div class="cell cell-f">
		<div class="box">
			<div class="box_title">
				Sequence
			</div>
			<div id="sequence">
				<% out.println(sequence.getSequenceHtml()); %>
			</div>
			<div id="sequencebuttons">
				<button onclick="leftout();"><</button>
				<button onclick="leftin();">></button>
				<button onclick="reset();">Reset</button>
				<button onclick="rightin();"><</button>
				<button onclick="rightout();">></button>
			</div>
		</div>
	</div>

	<div class="cell">
		<div class="box">
			<div class="box_title">
				PDB Details
			</div>
			<table>
					<tr>
						<td class="field">PDB code</td>
						<td class="value"><a href="http://www.rcsb.org/pdb/explore.do?structureId=<% out.print(sequence.getPdb()); %>" target="_blank"><% out.print(sequence.getPdb()); %></a></td>
					</tr>
					<tr>
						<td class="field">HET ID</td>
						<td class="value"><% out.print(sequence.getHetId()); %></td>
					</tr>
					<tr>
						<td class="field">HET name</td>
						<td class="value"><% out.print(sequence.getHetCode()); %></td>
					</tr>
					<tr>
						<td class="field">Receptor Chain</td>
						<td class="value"><% out.print(sequence.getChain()); %></td>
					</tr>
				</table>
		</div>
	</div>

	<div class="cell">
		<div class="box">
			<div class="box_title">
				Other Details
			</div>
			<table>
					<tr>
						<td class="field">Target Type</td>
						<td class="value"><% out.print(sequence.getTargetType()); %></td>
					</tr>
					<tr>
						<td class="field">Affinity</td>
						<td class="value"><% out.print(sequence.getAffinity()); %></td>
					</tr>
					<tr>
						<td class="field">Affinity type</td>
						<td class="value"><% out.print(sequence.getAffinityType()); %></td>
					</tr>
					<tr>
						<td class="field"><div class="help" title="The number of residues the binding sequence has.">?</div>Sequence length</td>
						<td class="value"><% out.print(sequence.getSequenceLength()); %></td>
					</tr>
					<tr>
						<td class="field"><div class="help" title="The length of the sequence compared with the chain it comes from - smaller values indicate a more useful cassette.">?</div>Proportion of original chain length</td>
						<td class="value"><% out.print(Utilities.floatToPercentage(sequence.getProportionalLength())); %></td>
					</tr>
					<tr>
						<td class="field"><div class="help" title="The number of atomic contacts within the sequence, exlcuding those between adjacent residues.">?</div>Internal contacts</td>
						<td class="value"><% out.print(sequence.getInternalContacts()); %></td>
					</tr>
					<tr>
						<td class="field"><div class="help" title="The number of atomic contacts between the sequence and the rest of its chain.">?</div>External contacts</td>
						<td class="value"><% out.print(sequence.getExternalContacts()); %></td>
					</tr>
					<tr>
						<td class="field"><div class="help" title="The ratio of the above two values - the higher this is, the more intenral contacts predominate, and the more modular the construct is likely to be.">?</div>Contact ratio</td>
						<td class="value"><% out.print(sequence.getContactRatio()); %></td>
					</tr>
				</table>
		</div>
	</div>

	<div class="cell cell-f">
		<div class="box" style="overflow:scroll;position:relative;webkit-overflow-scrolling:touch;">
			<div class="box_title">
				Features
			</div>
			<iframe seamless='seamless' style="overflow:scroll;webkit-overflow-scrolling:touch;position:relative;width:100%;" height="450px" src="/static/features/<% out.print(sequence.getSequenceId()); %>.html"></iframe>
		</div>
	</div>

	<div class="cell cell-f">
		<div class="box" style="overflow:scroll;position:relative;">
			<div class="box_title">
				Residue Distances
			</div>
			<iframe seamless='seamless' style="overflow:scroll;position:relative;width:100%;" height="750px" src="/static/matrices/<% out.print(sequence.getSequenceId()); %>.html"></iframe>
		</div>
	</div>

</div>


<script type="text/javascript">
    function resize_canvas(){
        var canvas = document.getElementById("viewer").getElementsByTagName("canvas")[0];
				var box = document.getElementById("pv-box");
				canvas.width = box.clientWidth;
    }
	document.getElementsByTagName("body")[0].onresize = resize_canvas;
</script>
<%@include file="/includes/bodybottom.html"%>
