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
  var sequence = document.getElementById("sequence");
  for (var i = 0; i < sequence.children.length; i++) {
    if (sequence.children[i].className.includes("up")) {
      break;
    }
    if (sequence.children[i].className.includes("inside")) {
      sequence.children[i].className = "between outside";
      break;
    }
  }
}

function reset() {
  var sequence = document.getElementById("sequence");
  for (var i = 0; i < sequence.children.length; i++) {
    if (sequence.children[i].className.includes("up")) {
      for (var j = 0; j < i; j++) {
        sequence.children[j].className = "between outside";
      }
      break;
    }
  }
  for (var i = sequence.children.length - 1; i > 0; i--) {
    if (sequence.children[i].className.includes("up")) {
      for (var j = sequence.children.length - 1; j > i; j--) {
        sequence.children[j].className = "between outside";
      }
      break;
    }
  }
}

function rightin() {
  var sequence = document.getElementById("sequence");
  for (var i = sequence.children.length - 1; i > 0; i--) {
    if (sequence.children[i].className.includes("up")) {
      break;
    }
    if (sequence.children[i].className.includes("inside")) {
      sequence.children[i].className = "between outside";
      break;
    }
  }
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
