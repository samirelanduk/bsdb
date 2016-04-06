var descriptions = ["All drug-responsive elements which respond to a Guide to PHARMACOLOGY ligand",
                    "Sequences which respond to approved drugs only",
                    "Sequences less than 100 residues in length",
                    "Sequences at least 100 residues in length",
                    "Hydrophobic sequences",
                    "Hydrophilic sequences",
                    "Sequences less than 30% of the original chain length"
                    ]

var functions = [function() {return true;},
                 isApproved,
                 isShort,
                 isLong,
                 isHydrophobic,
                 isHydrophilic,
                 isSmallProportional];



function isApproved(row) {
	if (row.children[6].innerHTML == "Yes") {
		return true;
	} else {
		return false;
	}
}

function isShort(row) {
	if (parseInt(row.children[4].innerHTML) < 100) {
		return true;
	} else {
		return false;
	}
}

function isLong(row) {
	if (parseInt(row.children[4].innerHTML) >= 100) {
		return true;
	} else {
		return false;
	}
}

function isHydrophobic(row) {
	return true;
}

function isHydrophilic(row) {
	return true;
}

function isSmallProportional(row) {
	if (parseInt(row.children[5].innerHTML) < 30) {
		return true;
	} else {
		return false;
	}
}