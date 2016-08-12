var descriptions = ["All drug-responsive elements which respond to a Guide to PHARMACOLOGY ligand",
                    "Sequences which respond to approved drugs only",
                    "Sequences less than 100 residues in length",
                    "Sequences at least 100 residues in length",
                    "Sequences derived from human proteins",
                    "Sequences derived from non-human proteins",
                    "Sequences less than 30% of the original chain length"
                    ]

var functions = [function() {return true;},
                 isApproved,
                 isShort,
                 isLong,
                 isHuman,
                 isNonHuman,
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

function isHuman(row) {
  if (row.children[2].innerHTML == "Human") {
		return true;
	} else {
		return false;
	}
}

function isNonHuman(row) {
  if (row.children[2].innerHTML != "Human") {
    return true;
  } else {
    return false;
  }
}

function isSmallProportional(row) {
	if (parseInt(row.children[5].innerHTML) < 30) {
		return true;
	} else {
		return false;
	}
}
