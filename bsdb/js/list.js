function selectRows(functionNumber) {

	var rows = document.getElementsByTagName("tr");
	var visibleCount = 0;
	for (var i = 1; i < rows.length; i++) {
		if (functions[functionNumber](rows[i])) {
			rows[i].style.display = "table-row";
			visibleCount++;
		} else {
			rows[i].style.display = "none";
		}
	}

	var headers = document.getElementById("list_categories").children;
	for (var i = 0; i < (headers.length - 1); i++) {
		headers[i].className = "list_category unselected";
	}
	headers[functionNumber].className = "list_category selected";

	var description = document.getElementById("category_description");
	description.innerHTML = descriptions[functionNumber] + " (" + visibleCount + ").";

	colorRows();

}

var currentRowSortStatus;

function sortColumn(columnNumber) {
	var tbody = document.getElementsByTagName("tbody")[0];
	var table = tbody.parentNode;
	var thead = document.getElementsByTagName("thead")[0];
	var rows = tbody.getElementsByTagName("tr");
	currentRowStatus = thead.children[0].children[columnNumber].className;

	var sortTerms = [];
	for (var i = 0; i < rows.length; i++) {
		term = rows[i].childNodes[columnNumber].attributes.value.value.toLowerCase();
		if (!(term.match(/[a-z]/i))) {
			term = parseFloat(term);
		}
		sortTerms.push(term);
	}
	var searchableRows = [];
	for (var i = 0; i < rows.length; i++) {
		searchableRows.push([sortTerms[i], rows[i]]);
	}

	searchableRows.sort(getSortValue);
	rows = [];
	sortTerms = [];
	for (var i = 0; i < searchableRows.length; i++) {
		rows.push(searchableRows[i][1]);
	}
	for (var i = 0; i < searchableRows.length; i++) {
		sortTerms.push(searchableRows[i][0]);
	}
	var newRows = document.createDocumentFragment();
	for (var i = 0; i < searchableRows.length; i++) {
		newRows.appendChild(searchableRows[i][1]);
	}

	table.removeChild(tbody);
	var newTbody = document.createElement("tbody");
	newTbody.setAttribute("id", "tbody");
	newTbody.appendChild(newRows);
	table.appendChild(newTbody);

	thead.children[0].children[columnNumber].className = currentRowStatus == "A" ? "D" : "A";

	colorRows();
}


function getSortValue(valueRow1, valueRow2) {
	if (valueRow1[0] < valueRow2[0]) {
		return currentRowStatus == "A" ? 1 : -1;
	}

	if (valueRow1[0] > valueRow2[0]) {
		return currentRowStatus == "A" ? -1 : 1;
	}
	return 0;
}

function colorRows() {
	var rows = document.getElementsByTagName("tr");
	var next = 1;
	var values = ["light", "dark"];

	for (var i = 1; i < rows.length; i++) {
		if (rows[i].style.display != "none") {
			rows[i].className = values[next];
			next = (next == 1 ? 0 : 1);
		}
	}
}
