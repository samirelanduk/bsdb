<%@ page import = "org.synpharm.*" %>
<%@ page import = "java.util.*" %>
<%
long[] ligandTypeCounts = DatabaseAccess.getLigandTypeCounts();
Object[][] ligandMassDistribution = DatabaseAccess.getLigandMassDistribution();
String[] ligandMassBins = new String[ligandMassDistribution.length];
long[] ligandMasses = new long[ligandMassDistribution.length];
for (int i = 0; i < ligandMassBins.length; i++) {
	ligandMassBins[i] = "'" + (String)ligandMassDistribution[i][0] + "'";
	ligandMasses[i] = (Long)ligandMassDistribution[i][1];
}
long[] ligandApprovalCounts = DatabaseAccess.getLigandApprovalCounts();
long[] sequenceTypeCounts = DatabaseAccess.getSequenceTypeCounts();
Object[][] sequenceLengthDistribution = DatabaseAccess.getSequenceLengthDistribution();
String[] sequenceLengthBins = new String[sequenceLengthDistribution.length];
long[] sequenceLengths = new long[sequenceLengthDistribution.length];
for (int i = 0; i < sequenceLengthBins.length; i++) {
	sequenceLengthBins[i] = "'" + (String)sequenceLengthDistribution[i][0] + "'";
	sequenceLengths[i] = (Long)sequenceLengthDistribution[i][1];
}
ArrayList<int[][]> sequenceContiguity = DatabaseAccess.getSequenceContiguity();
%>

<%@include file="/includes/start.html"%>
<title>Data and Statistics - BindSequenceDB</title>
<link rel="stylesheet" type="text/css" href="/css/charts.css">
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>
<style>
	h1 {
		margin-left: 5%;
	}
</style>
<%@include file="/includes/bodytop.html"%>

<h1>Data and Statistics</h1>

<div id="ligand_stats">

	<div class="box">
		<div class="box_title">
			Ligands by Type
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the ligands in the SynPharm database by Guide to PHARMACOLOGY
				type.
			</div>
			<div class="boxtable">
				<div class="cell cell-l">
						<table class="datatable">
							<tr><td>Synthetic Organic</td><td><% out.print(ligandTypeCounts[0]); %></td></tr>
							<tr><td>Metabolite</td><td><% out.print(ligandTypeCounts[1]); %></td></tr>
							<tr><td>Natural Product</td><td><% out.print(ligandTypeCounts[2]); %></td></tr>
							<tr><td>Peptide</td><td><% out.print(ligandTypeCounts[3]); %></td></tr>
							<tr><td>Inorganic</td><td><% out.print(ligandTypeCounts[4]); %></td></tr>
							<tr><td>Antibody</td><td><% out.print(ligandTypeCounts[5]); %></td></tr>
						</table>
				</div>

				<div id="ligandTypesChart" class="cell cell-r">
					<script>
						var chart = new Highcharts.Chart({
			        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false,
		            type: 'pie',
								renderTo: 'ligandTypesChart'
			        },
			        title: {
		            text: 'Ligand Types'
			        },
			        tooltip: {
		            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			        },
			        plotOptions: {
		            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                  enabled: true,
	                  format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                  style: {
	                  	color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                  }
	                }
		            }
			        },
			        series: [{
		            name: 'Proportion',
		            colorByPoint: true,
		            data: [{
	                name: 'Synthetic Organic',
	                y: <% out.print(ligandTypeCounts[0]); %>
		            }, {
	                name: 'Metabolite',
	                y: <% out.print(ligandTypeCounts[1]); %>
		            }, {
	                name: 'Natural Product',
	                y: <% out.print(ligandTypeCounts[2]); %>
		            }, {
	                name: 'Peptide',
	                y: <% out.print(ligandTypeCounts[3]); %>
		            }, {
	                name: 'Inorganic',
	                y: <% out.print(ligandTypeCounts[4]); %>
		            }, {
	                name: 'Antibody',
	                y:<% out.print(ligandTypeCounts[5]); %>
		            }]
			        }]
					  });
					</script>
				</div>
			</div>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Ligands by Mass
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the ligands in the SynPharm database by mass.
			</div>
			<div class="boxtable">
				<div class="cell cell-l">
					<table class="datatable">
						<thead><th>Ligand Mass (Da)</th><th>Count</th></thead>
						<% for (int i = 0; i < ligandMassDistribution.length; i++) {
							 	if ((Long)ligandMassDistribution[i][1] != 0) {
									out.println(String.format("<tr><td>%s</td><td>%d</td</tr>", ligandMassDistribution[i][0], ligandMassDistribution[i][1]));
								}
						} %>

					</table>
				</div>
				<div id="ligandMassChart" class="cell cell-r">
						<script>
					    var chart = new Highcharts.Chart({
					        chart: {
					            type: 'column',
											renderTo: 'ligandMassChart',
											zoomType: 'x'
					        },
					        title: {
					            text: 'Ligand Mass Distribution'
					        },
					        xAxis: {
					            categories: [
												<% for (int i = 0; i < ligandMassDistribution.length; i++) {
															out.println(String.format("'%s',", ligandMassDistribution[i][0]));
												} %>
					            ],
					            crosshair: true
					        },
					        yAxis: {
					            min: 0,
					            title: {
					                text: 'Count'
					            }
					        },
					        tooltip: {
					            headerFormat: '<span style="font-size:10px">{point.key} Da</span><table>',
					            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					                '<td style="padding:0"><b>{point.y}</b></td></tr>',
					            footerFormat: '</table>',
					            shared: true,
					            useHTML: true
					        },
					        plotOptions: {
					            column: {
					                pointPadding: 0.2,
					                borderWidth: 0
					            }
					        },
					        series: [{
					            name: 'Ligand Count',
					            data: <% out.print(Arrays.toString(ligandMasses)); %>

					        }]
					    });
						</script>
					</div>
			</div>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Ligands by Approval Status
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the ligands in the SynPharm database by approval status.
			</div>
			<div class="boxtable">
				<div class="cell cell-l">
					<table class="datatable">
						<tr><td>Approved</td><td><% out.print(ligandApprovalCounts[0]); %></td></tr>
						<tr><td>Not Approved</td><td><% out.print(ligandApprovalCounts[1]); %></td></tr>
					</table>
				</div>
				<div id="ligandApprovalChart" class="cell cell-r">
					<script>
						var chart = new Highcharts.Chart({
							chart: {
								plotBackgroundColor: null,
								plotBorderWidth: null,
								plotShadow: false,
								type: 'pie',
								renderTo: 'ligandApprovalChart'
							},
							title: {
								text: 'Ligand Approval'
							},
							tooltip: {
								pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							plotOptions: {
								pie: {
									allowPointSelect: true,
									cursor: 'pointer',
									dataLabels: {
										enabled: true,
										format: '<b>{point.name}</b>: {point.percentage:.1f} %',
										style: {
											color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
										}
									}
								}
							},
							series: [{
								name: 'Proportion',
								colorByPoint: true,
								data: [{
									name: 'Approved',
									y: <% out.print(ligandApprovalCounts[0]); %>,
									color: '#2ECC40'
								}, {
									name: 'Not Approved',
									y: <% out.print(ligandApprovalCounts[1]); %>,
									color: '#FF4136'
								}]
							}]
						});
					</script>
				</div>
			</div>
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
				A breakdown of the sequences in the SynPharm database by Guide to PHARMACOLOGY
				target type.
			</div>
			<div class="boxtable">
				<div class="cell cell-l">
					<table class="datatable">
						<tr><td>GPCR</td><td><% out.print(sequenceTypeCounts[0]); %></td></tr>
						<tr><td>LGIC</td><td><% out.print(sequenceTypeCounts[1]); %></td></tr>
						<tr><td>VGIC</td><td><% out.print(sequenceTypeCounts[2]); %></td></tr>
						<tr><td>Other Ion Channel</td><td><% out.print(sequenceTypeCounts[3]); %></td></tr>
						<tr><td>NHR</td><td><% out.print(sequenceTypeCounts[4]); %></td></tr>
						<tr><td>Enzyme</td><td><% out.print(sequenceTypeCounts[5]); %></td></tr>
						<tr><td>Catalytic Receptor</td><td><% out.print(sequenceTypeCounts[6]); %></td></tr>
						<tr><td>Transporter</td><td><% out.print(sequenceTypeCounts[7]); %></td></tr>
						<tr><td>Other Protein</td><td><% out.print(sequenceTypeCounts[8]); %></td></tr>
					</table>
				</div>

				<div id="sequenceTypesChart" class="cell cell-r">
					<script>
						var chart = new Highcharts.Chart({
							chart: {
								plotBackgroundColor: null,
								plotBorderWidth: null,
								plotShadow: false,
								type: 'pie',
								renderTo: 'sequenceTypesChart'
							},
							title: {
								text: 'Sequence Types'
							},
							tooltip: {
								pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
							},
							plotOptions: {
								pie: {
									allowPointSelect: true,
									cursor: 'pointer',
									dataLabels: {
										enabled: true,
										format: '<b>{point.name}</b>: {point.percentage:.1f} %',
										style: {
											color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
										}
									}
								}
							},
							series: [{
								name: 'Proportion',
								colorByPoint: true,
								data: [{
									name: 'GPCR',
									y: <% out.print(sequenceTypeCounts[0]); %>
								}, {
									name: 'LGIC',
									y: <% out.print(sequenceTypeCounts[1]); %>
								}, {
									name: 'VGIC',
									y: <% out.print(sequenceTypeCounts[2]); %>
								}, {
									name: 'Other Ion Channel',
									y: <% out.print(sequenceTypeCounts[3]); %>
								}, {
									name: 'NHR',
									y: <% out.print(sequenceTypeCounts[4]); %>
								}, {
									name: 'Enzyme',
									y: <% out.print(sequenceTypeCounts[5]); %>
								}, {
									name: 'Catalytic Receptor',
									y:<% out.print(sequenceTypeCounts[6]); %>
								}, {
									name: 'Transporter',
									y: <% out.print(sequenceTypeCounts[7]); %>
								}, {
									name: 'Other Protein',
									y: <% out.print(sequenceTypeCounts[8]); %>
								}]
							}]
						});
					</script>
				</div>
			</div>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Sequences by Length
		</div>
		<div class="box_body">
			<div class="explanation">
				A breakdown of the sequences in the SynPharm database by sequence length.
			</div>
			<div class="boxtable">
				<div class="cell cell-l">
					<table class="datatable">
						<thead><th>Sequence Length (residues)</th><th>Count</th></thead>
						<% for (int i = 0; i < sequenceLengthDistribution.length; i++) {
									out.println(String.format("<tr><td>%s</td><td>%d</td</tr>", sequenceLengthDistribution[i][0], sequenceLengthDistribution[i][1]));
						} %>

					</table>
				</div>
				<div id="sequenceLengthChart" class="cell cell-r">
					<script>
				    var chart = new Highcharts.Chart({
				        chart: {
				            type: 'column',
										renderTo: 'sequenceLengthChart'
				        },
				        title: {
				            text: 'Sequence Length Distribution'
				        },
				        xAxis: {
				            categories: [
											<% for (int i = 0; i < sequenceLengthDistribution.length; i++) {
														out.println(String.format("'%s',", sequenceLengthDistribution[i][0]));
											} %>
				            ],
				            crosshair: true
				        },
				        yAxis: {
				            min: 0,
				            title: {
				                text: 'Count'
				            }
				        },
				        tooltip: {
				            headerFormat: '<span style="font-size:10px">{point.key} residues</span><table>',
				            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
				                '<td style="padding:0"><b>{point.y}</b></td></tr>',
				            footerFormat: '</table>',
				            shared: true,
				            useHTML: true
				        },
				        plotOptions: {
				            column: {
				                pointPadding: 0.2,
				                borderWidth: 0
				            }
				        },
				        series: [{
				            name: 'Sequence Count',
				            data: <% out.print(Arrays.toString(sequenceLengths)); %>

				        }]
				    });
					</script>
				</div>
			</div>
		</div>
	</div>

	<div class="box">
		<div class="box_title">
			Sequence Contiguity by Target Type
		</div>
		<div class="box_body">
			<div class="explanation">
				This is a measure of how close together on the sequence the actual
				binding residues are - sequences with low contiguity will have widely
				separated residues. Here it is represented as the proportion of binding
				residues to non-binding residues.
			</div>
			<div id="sequenceContiguityChart"></div>
			<script>
		    var chart = new Highcharts.Chart({
		        chart: {
		            type: 'scatter',
		            zoomType: 'xy',
								renderTo: 'sequenceContiguityChart'
		        },
		        title: {
		            text: 'Sequence Binding Residue Proportion'
		        },
		        xAxis: {
		            title: {
		                enabled: true,
		                text: 'Sequence Length (residues)'
		            },
		            startOnTick: true,
		            endOnTick: true,
		            showLastLabel: true
		        },
		        yAxis: {
		            title: {
		                text: 'Number of Binding Residues'
		            },
								allowDecimals: false
		        },
		        legend: {
		            layout: 'horizontal',
		            align: 'center',
		            verticalAlign: 'top',
		            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
		            borderWidth: 1
		        },
		        plotOptions: {
		            scatter: {
		                marker: {
		                    radius: 2,
		                    states: {
		                        hover: {
		                            enabled: true,
		                            lineColor: 'rgb(100,100,100)'
		                        }
		                    }
		                },
		                states: {
		                    hover: {
		                        marker: {
		                            enabled: false
		                        }
		                    }
		                },
		                tooltip: {
		                    headerFormat: '<b>{series.name}</b><br>',
		                    pointFormat: '{point.x} total residues, {point.y} binding residues'
		                }
		            }
		        },
		        series: [{
		            name: 'GPCR',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(0))); %>
		        }, {
		            name: 'LGIC',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(1))); %>
		        }, {
		            name: 'VGIC',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(2))); %>
		        }, {
		            name: 'Other Ion Channel',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(3))); %>
		        }, {
		            name: 'NHR',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(4))); %>
		        }, {
		            name: 'Enzyme',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(5))); %>
		        }, {
		            name: 'Catalytic Receptor',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(6))); %>
		        }, {
		            name: 'Transporter',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(7))); %>
		        }, {
		            name: 'Other Protein',
		            data: <% out.print(Arrays.deepToString(sequenceContiguity.get(8))); %>
		        }]
		    });
			</script>
		</div>
	</div>

</div>

<div id="aboutback">
	<a href="/about">Back to About</a>
</div>

<%@include file="/includes/bodybottom.html"%>
