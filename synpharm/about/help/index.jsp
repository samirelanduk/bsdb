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
				ligand (if available – generally peptides and ligands do not have such
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
				Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer
				nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.
			 	Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum.
			 	Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris
			 	massa. Vestibulum lacinia arcu eget nulla.
			</p>
			<p>
				Class aptent taciti sociosqu ad litora torquent per conubia
				nostra, per inceptos himenaeos. Curabitur sodales ligula in libero.
				Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh.
				Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed
				convallis tristique sem. Proin ut ligula vel nunc egestas porttitor.
			 	Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa.
				Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla
				metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh.
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
				Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer
				nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.
			 	Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum.
			 	Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris
			 	massa. Vestibulum lacinia arcu eget nulla.
			</p>
			<p>
				Class aptent taciti sociosqu ad litora torquent per conubia
				nostra, per inceptos himenaeos. Curabitur sodales ligula in libero.
				Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh.
				Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed
				convallis tristique sem. Proin ut ligula vel nunc egestas porttitor.
			 	Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa.
				Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla
				metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh.
			</p>
		</div>
	</div>
</div>

<div id="aboutback">
	<a href="/about">Back to About</a>
</div>
<%@include file="/includes/bodybottom.html"%>
