
function hideFlashMessages() {
  const noticeFlash = document.getElementById("notice-flash");
  const alertFlash = document.getElementById("alert-flash");

  if (noticeFlash) {
    setTimeout(function () {
      noticeFlash.style.display = "none";
    }, 5000); 
  }

  if (alertFlash) {
    setTimeout(function () {
      alertFlash.style.display = "none";
    }, 5000); 
  }
}

window.addEventListener("DOMContentLoaded", hideFlashMessages);
