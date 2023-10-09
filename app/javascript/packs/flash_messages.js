// Function to hide the flash messages after a specified timeout
function hideFlashMessages() {
  const noticeFlash = document.getElementById("notice-flash");
  const alertFlash = document.getElementById("alert-flash");

  // Check if the notice flash element exists and hide it after 5 seconds
  if (noticeFlash) {
    setTimeout(function () {
      noticeFlash.style.display = "none";
    }, 5000); // 5000 milliseconds (5 seconds)
  }

  // Check if the alert flash element exists and hide it after 5 seconds
  if (alertFlash) {
    setTimeout(function () {
      alertFlash.style.display = "none";
    }, 5000); // 5000 milliseconds (5 seconds)
  }
}

// Call the hideFlashMessages function when the page loads
window.addEventListener("DOMContentLoaded", hideFlashMessages);
a