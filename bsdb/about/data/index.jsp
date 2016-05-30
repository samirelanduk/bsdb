<%@ page import = "org.bsdb.*" %>
<%@ page import = "java.util.*" %>
<%
long[] ligandTypeCounts = DatabaseAccess.getLigandTypeCounts();
Object[][] ligandMassDistribution = DatabaseAccess.getLigandMassDsitribution();
String[] ligandMassBins = new String[ligandMassDistribution.length];
long[] ligandMasses = new long[ligandMassDistribution.length];
for (int i = 0; i < ligandMassBins.length; i++) {
	ligandMassBins[i] = "'" + (String)ligandMassDistribution[i][0] + "'";
	ligandMasses[i] = (Long)ligandMassDistribution[i][1];
}
%>

<%@include file="/includes/start.html"%>
<title>Data and Statistics - BindSequenceDB</title>
<link rel="stylesheet" type="text/css" href="/css/charts.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>
<%@include file="/includes/bodytop.html"%>

<h1>Data and Statistics</h1>

<div id="ligand_stats">

	<div class="box">
		<div class="box_title">
			Ligands by Type
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the ligands in the BSDB database by Guide to PHARMACOLOGY
				type.
			</div>
			<table class="boxtable">
				<tr>
					<td>
						<table class="datatable">
							<tr><td>Synthetic Organic</td><td><% out.print(ligandTypeCounts[0]); %></td></tr>
							<tr><td>Metabolite</td><td><% out.print(ligandTypeCounts[1]); %></td></tr>
							<tr><td>Natural Product</td><td><% out.print(ligandTypeCounts[2]); %></td></tr>
							<tr><td>Endogenous Peptide</td><td><% out.print(ligandTypeCounts[3]); %></td></tr>
							<tr><td>Other Peptide</td><td><% out.print(ligandTypeCounts[4]); %></td></tr>
							<tr><td>Inorganic</td><td><% out.print(ligandTypeCounts[5]); %></td></tr>
							<tr><td>Antibody</td><td><% out.print(ligandTypeCounts[6]); %></td></tr>
						</table>
					</td><td>
						<canvas id="ligandTypeChart"></canvas>
						<script>
						var ctx = document.getElementById("ligandTypeChart");
						var myChart = new Chart(ctx, {
						    type: 'pie',
						    data: {
						        labels: ["Synthetic Organic", "Metabolite", "Natural Product", "Endogenous Peptide", "Other Peptide", "Inorganic", "Antibody"],
						        datasets: [{
						            label: 'Count',
						            data: <% out.print(Arrays.toString(ligandTypeCounts)); %>,
						            backgroundColor: [
						                'rgba(255, 99, 132, 0.2)',
						                'rgba(54, 162, 235, 0.2)',
						                'rgba(255, 206, 86, 0.2)',
						                'rgba(75, 192, 192, 0.2)',
						                'rgba(153, 102, 255, 0.2)',
						                'rgba(255, 159, 64, 0.2)'
						            ],
						            borderColor: [
						                'rgba(255,99,132,1)',
						                'rgba(54, 162, 235, 1)',
						                'rgba(255, 206, 86, 1)',
						                'rgba(75, 192, 192, 1)',
						                'rgba(153, 102, 255, 1)',
						                'rgba(255, 159, 64, 1)'
						            ],
						            borderWidth: 1
						        }]
						    }
						});
						</script>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Ligands by Mass
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the ligands in the BSDB database by mass.
			</div>
			<table class="boxtable">
				<tr>
					<td>
						<table class="datatable">
							<thead><th>Ligand Mass (Da)</th><th>Count</th></thead>
							<% for (int i = 0; i < ligandMassDistribution.length; i++) {
										out.println(String.format("<tr><td>%s</td><td>%d</td</tr>", ligandMassDistribution[i][0], ligandMassDistribution[i][1]));
							} %>

						</table>
					</td><td>
						<canvas id="ligandMassChart"></canvas>
						<script>
						var ctx = document.getElementById("ligandMassChart");
						var myChart = new Chart(ctx, {
						    type: 'bar',
						    data: {
						        labels: <% out.print(Arrays.toString(ligandMassBins)); %>,
						        datasets: [{
												label: "Number of ligands",
						            data: <% out.print(Arrays.toString(ligandMasses)); %>,
						            borderWidth: 1,
												backgroundColor: "rgba(255,99,132,0.8)"
						        }]
						    }
						});
						</script>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Ligands by Approval Status
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

</div>

<div id="sequence_stats">

	<div class="box">
		<div class="box_title">
			Sequences by Target Type
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Sequences by Mass
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Sequence Contiguity by Target Type
		</div>
		<div class="box_body">
			<div class="explanation">
			</div>
			<svg>
			</svg>
		</div>
	</div>

</div>

<div id="aboutback">
	<a href="/about">Back to About</a>
</div>

<%@include file="/includes/bodybottom.html"%>
