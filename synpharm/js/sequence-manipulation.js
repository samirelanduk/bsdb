function leftout() {
  var sequence = document.getElementById("sequence");
  for (var i = 0; i < sequence.children.length; i++) {
    if ((sequence.children[i].className.indexOf("inside") > -1) && (i != 0)) {
      sequence.children[i - 1].className = sequence.children[i - 1].className.replace("outside", "inside");
      break;
    }
  }
}

function leftin() {
  var sequence = document.getElementById("sequence");
  for (var i = 0; i < sequence.children.length; i++) {
    if (sequence.children[i].className.indexOf("up") > -1) {
      break;
    }
    if (sequence.children[i].className.indexOf("inside") > -1) {
      sequence.children[i].className = sequence.children[i].className.replace("inside", "outside");
      break;
    }
  }
}

function reset() {
  var sequence = document.getElementById("sequence");
  for (var i = 0; i < sequence.children.length; i++) {
    if (sequence.children[i].className.indexOf("up") > -1) {
      for (var j = 0; j < i; j++) {
        sequence.children[j].className = sequence.children[j].className.replace("inside", "outside");
      }
      break;
    }
  }
  for (var i = sequence.children.length - 1; i > 0; i--) {
    if (sequence.children[i].className.indexOf("up") > -1) {
      for (var j = sequence.children.length - 1; j > i; j--) {
        sequence.children[j].className = sequence.children[j].className.replace("inside", "outside");
      }
      break;
    }
  }
}

function rightin() {
  var sequence = document.getElementById("sequence");
  for (var i = sequence.children.length - 1; i > 0; i--) {
    if (sequence.children[i].className.indexOf("up") > -1) {
      break;
    }
    if (sequence.children[i].className.indexOf("inside") > -1) {
      sequence.children[i].className = sequence.children[i].className.replace("inside", "outside");
      break;
    }
  }
}

function rightout() {
  var sequence = document.getElementById("sequence");
  for (var i = sequence.children.length - 1; i > 0; i--) {
    if ((sequence.children[i].className.indexOf("inside") > -1) && (i != sequence.children.length - 1)) {
      sequence.children[i + 1].className = sequence.children[i + 1].className.replace("outside", "inside");
      break;
    }
  }
}
