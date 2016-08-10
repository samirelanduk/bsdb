function leftout() {
  var sequence = document.getElementById("sequence");
  for (var i = 0; i < sequence.children.length; i++) {
    if ((sequence.children[i].className.includes("inside")) && (i != 0)) {
      sequence.children[i - 1].className = "between inside";
      break;
    }
  }
}

function leftin() {

}

function reset() {

}

function rightin() {

}

function rightout() {
  var sequence = document.getElementById("sequence");
  for (var i = sequence.children.length - 1; i > 0; i--) {
    if ((sequence.children[i].className.includes("inside")) && (i != sequence.children.length - 1)) {
      sequence.children[i + 1].className = "between inside";
      break;
    }
  }
}
