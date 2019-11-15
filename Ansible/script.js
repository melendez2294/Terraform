const testWrapper = document.querySelector(".test-wrapper");
const testArea = document.querySelector("#test-area");
const originText = document.querySelector("#origin-text p").innerHTML;
const resetButton = document.querySelector("#reset");
const theTimer = document.querySelector(".timer");

var interval;
var clock = [0, 0, 0, 0];
var started = 0;
var digit;

// Add leading zero to numbers 9 or below (purely for aesthetics):

function zero(digit) {
	if (digit <= 9) {
		digit = "0" + digit;
	}
	return digit;
}

// Run a standard minute/second/hundredths timer:

function runClock() {
	var runClock = zero(clock[0]) + ":" + zero(clock[1]) + ":" + zero(clock[2]);
    theTimer.innerHTML = runClock;
      clock[0] = Math.floor(clock[3] / 6000);
      clock[1] = Math.floor(clock[3] / 100 - clock[0] * 60);
      clock[2] = Math.floor(clock[3] - clock[0] * 6000 - clock[1] * 100);
      clock[3]++;
}


// Match the text entered with the provided text on the page:

function match() {
  var textMatch = originText.substring(0, testArea.value.length);
    if (testArea.value == originText) {
      testWrapper.style.borderColor = "#66E766";
      theTimer.style.color = "#66E766";
      clearInterval(interval);
    }
    
    else if (testArea.value  == textMatch) {
      testWrapper.style.borderColor = "#66E766";
    } 
    
    else {
      testWrapper.style.borderColor = "#ED3D28";
    }
}


// Start the timer:

function start() {
  if (testArea.value.length === 0 && started == 0) {
    started = 1;
    interval = setInterval(runClock, 10);
  }
}

// Reset everything:

function reset() {
  clearInterval(interval);
  interval = null;
  theTimer.innerHTML = "00:00:00";
  started = 0;
  clock = [0, 0, 0, 0];
  testArea.value = "";
  testWrapper.style.borderColor = "#E9F1FF";
  theTimer.style.color = "#FFFFFF";
}

// Event listeners for keyboard input and the reset button:

testArea.addEventListener("keypress", start, 1);
resetButton.addEventListener("click", reset, 1);
testArea.addEventListener("keyup", match, 1);