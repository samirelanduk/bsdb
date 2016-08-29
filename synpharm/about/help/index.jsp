<%@include file="/includes/start.html"%>
<title>Help - BindSequenceDB</title>
<%@include file="/includes/bodytop.html"%>

<h1>Help</h1>

<div class="box">
	<div class="box_title">
		Searching
	</div>
	<div class="box_body">
		<div class="help_subsection">
			<h2>Search by Ligand</h2>
			<p>
				The <a href="/search/#ligands">basic Ligand Search</a> allows you to enter a
				ligand's name - any ligands that at least partially match the query will
				be returned.
			</p>
			<p>
				The more <a href="/search/ligands/">advanced ligand search</a> allows
				for searching by essentially any combination of values that SynPharm
				records. This includes ligand mass, surface area, ligand type, approval
				status, and more.
			</p>
				If you require a more tailored search query, you can contact us directly.
			</p>
		</div>
		<div class="help_subsection">
			<h2>Search by Sequence</h2>
			<p>
				The bind sequences also have a <a href="/search/#sequences">basic search</a>
				box, which allows for searching by target name, as well as a more
				<a href="/search/sequences/">advanced search</a> feature that allows you
				to search by target type, sequence length, etc.
			</p>
			<p>
				Currently searching by sequence will only return exact matches. If you
				wish to BLAST search, consider using the Guide to PHARMACOLOGY's
				<a href="http://guidetopharmacology.org/blast/">BLAST search</a> feature.
			</p>
		</div>
	</div>
</div>

<div class="box">
	<div class="box_title">
		Ligands
	</div>
	<div class="box_body">
		<div class="help_subsection">
			<h2>Ligand list</h2>
			<p>
				The ligands in the database are listed <a href="/ligands/">here</a>,
				along with basic information about their approval status, GtoP type,
				mass, and any synonyms. This list can be sorted by any of these values
				(apart from synonyms), and the list can also be filtered to show only
				ligands of a certain type (or only approved ligands) by clicking the
				headers at the top of the list.
			</p>
			<p>
				Clicking the name of any of the ligands on this list will take you to
				that ligand's detailed page (see below).
			</p>
		</div>
		<div class="help_subsection">
			<h2>Ligand page</h2>
			<p>
				On the ligand's detailed page you will find more information about the
				ligand. This is just a subset of the information that the Guide to
				PHARMACOLOGY holds for the ligand - to see the full entry go to that
				ligand's GtoP page.
			</p>
			<p>
				The page contains links to other databases, a structural diagram of the
				ligand (if available - generally peptides and ligands do not have such
				images stored), and molecular information about the ligand, such as mass,
				surface area, and approval status.
			</p>
			<p>
				At the bottom of the page are links to the protein sequences which
				respond to this ligand.
			</p>
		</div>
	</div>
</div>

<div class="box">
	<div class="box_title">
		Sequences
	</div>
	<div class="box_body">
		<div class="help_subsection">
			<h2>Sequence list</h2>
			<p>
				The binding sequences in the database are listed here, along with basic
				information about the name of the target it is derived from, the species
				it is from, the ligand that binds to it, its length, and its length as a
				proportion of the protein chain it comes from. This list can be sorted
				by any of these values, and the list can also be filtered to show only
				sequences of a certain target type (or only sequence that respond to
				approved ligands) by clicking the headers at the top of the list.
			</p>
			<p>
				Clicking the sequence ID of any of the ligands on this list will take
				you to that sequence's detailed page (see below).
			</p>
		</div>
		<div class="help_subsection">
			<h2>Sequence page</h2>
			<p>
				At the top of sequence page is a 3D model of the binding sequence in
				complex with its ligand, which uses
				<a href="https://biasmv.github.io/pv/" target="_blank">PV, a JavaScript
				Protein Viewer</a>. This should work in all modern browsers, and can be
				used to visualise the complex.
			</p>
			<p>
				The sequence itself follows. The actual binding residues themselves are
				in bold, and the sequence can be expanded to include more of the rest of
				the chain using the buttons below the sequence.
			</p>
			<p>
				Then comes the metrics about the sequence. This includes links to the
				PDB file the sequence was derived from, as well as certain important
				descriptors:
			</p>
			<ul>
				<li><b>Affinity</b> - this is derived from the Guide to PHARMACOLOGY
				database, and as such are empirically determined values sourced from the
				literature.</li>
				<li><b>Proportional sequence length</b> - the length of the binding
				sequence compared with the length of the chain it comes from. This is
				provided to aid the decision of whether to use the sequence itself, or
				simply the chain it comes from - the higher this percentage, the more
				useful it is to use the sequence alone.</li>
				<li><b>Contact ratio</b> - to be useful these sequences must fold
				independently. Obviously this will not be the case for all the sequences
				here but to aid in judging how likely they are to do so, the ratio of internal
				contacts (atomic distances less than five Angstroms within the sequence)
				to external contacts (atomic distances between the sequence and the rest
				of the chain less than five Angstroms) is provided. This represents the
				degree to which the sequence is 'self-contained' - the higher this ratio,
				the more 'domain-like' the sequence is and the more likely it is believed
				to be able to fold independently.</li>
			</ul>
			<p>
				Below this is a feature viewer, which shows the location of binding
				residues and secondary structure elements along the sequence, as well as
				measures of hydrophobicity along the sequence.
			</p>
			<p>
				Finally, there is a residue distance matrix for the whole chain, with
				the binding sequence itself marked as a dotted line. This graphic shows
				the distance between any two given residues, with green representing
				nearby residues and red distant residues (capped at 40 Angstroms). This
				is provided to give a sense of how 'globular' a binding sequence is
				within its chain of origin - if the area within the dotted line is much
				greener than the surrounding area, it is a compact sequence.
			</p>
			<p>
				(Note that some areas of the matrix will be white - this is because some
				residues in that chain are missing from the PDB file of origin, and so
				there is no location information available.)
			</p>
		</div>
	</div>
</div>

<div class="box">
	<div class="box_title">
		General
	</div>
	<div class="box_body">
		<div class="help_subsection">
			<h2>Contacting us</h2>
			<p>
				This resource is maintained by the Guide to PHARMACOLOGY team. To contact
				a member of the team, use the
				<a href="https://www.google.com/recaptcha/mailhide/d?k=01vYhjd4942K8mcJsTfn9STA==&c=gyybhwWR1ziUWzMMiVIf72wtrsNBtTCzJMQcN2lPmvi7B4vjy65HPFlKpsLE3rQ7" target="_blank">
				e-mail address here</a> and indicate that your enquiry concerns SynPharm
				in the subject line.
			</p>
		</div>
	</div>
</div>

<div id="aboutback">
	<a href="/about">Back to About</a>
</div>
<%@include file="/includes/bodybottom.html"%>
