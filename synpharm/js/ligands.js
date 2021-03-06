var descriptions = ["All ligands with an affinity for one or more of the drug-responsive elements - both approved and unapproved by a regulatory body",
                    "Ligands approved by a regulatory body",
                    "Low molecular weight, non-polymeric compounds produced via either total synthesis or semi-synthetic processes",
                    "Low molecular weight, non-peptidic, biogenic compounds produced by life processes (normally endogenous and of animal origin, including hormones and neurotransmitters) and their close analogues",
                    "Non-peptidic, biogenic compounds derived from living organisms and their close synthetic derivatives",
                    "Includes synthetic and semi-synthetic peptides and peptides encoded in the genomes of humans and other organisms",
                    "Ions and other inorganic compounds",
                    "Includes therapeutic monoclonal antibodies"]

var functions = [function() {return true;},
                 isApproved,
                 isSyntheticOrganic,
                 isMetabolite,
                 isNaturalProduct,
                 isPeptide,
                 isInorganic,
                 isAntibody];



function isApproved(row) {
	if (row.children[2].innerHTML == "Yes") {
		return true;
	} else {
		return false;
	}
}

function isSyntheticOrganic(row) {
	console.log(document.getElementById("list_categories").children[2].innerHTML.replace("<br>", " "));
	if (row.children[3].innerHTML == document.getElementById("list_categories").children[2].innerHTML.trim()) {

		return true;
	} else {
		return false;
	}
}

function isMetabolite(row) {
	if (row.children[3].innerHTML == document.getElementById("list_categories").children[3].innerHTML.trim()) {
		return true;
	} else {
		return false;
	}
}

function isNaturalProduct(row) {
	if (row.children[3].innerHTML == document.getElementById("list_categories").children[4].innerHTML.trim()) {
		return true;
	} else {
		return false;
	}
}

function isPeptide(row) {
	if (row.children[3].innerHTML == document.getElementById("list_categories").children[5].innerHTML.trim()) {
		return true;
	} else {
		return false;
	}
}

function isInorganic(row) {
	if (row.children[3].innerHTML == document.getElementById("list_categories").children[6].innerHTML.trim()) {
		return true;
	} else {
		return false;
	}
}

function isAntibody(row) {
	if (row.children[3].innerHTML == document.getElementById("list_categories").children[7].innerHTML.trim()) {
		return true;
	} else {
		return false;
	}
}
