// javascript/packs/notifications.js

$(document).ready(function () {
  var readButton = document.getElementById("readbtn");

  if (readButton) {
    readButton.addEventListener("click", function (event) {
      event.preventDefault();
      var btnSelect = readButton.value;

      $.ajax({
        url: "/markread",
        method: "POST",
        data: {
          selected_btn: btnSelect,
          authenticity_token: $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          // Update notification count to 0
          var notificationCount = document.getElementById("notification-count");
          if (notificationCount) {
            notificationCount.innerText = "0";
          }

          // Hide the notification list
          var notificationList = document.getElementById("notification-list");
          if (notificationList) {
            notificationList.style.display = "none";
          }
        },
        error: function (xhr, status, error) {
          alert("Failed to mark as read");
        },
      });
    });
  }
});
