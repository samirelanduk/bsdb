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
