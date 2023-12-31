import consumer from "./consumer";

document.addEventListener("DOMContentLoaded", function() {
  consumer.subscriptions.create({ channel: "NotificationChannel" }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Connected to the NotificationChannel!");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log("Receiving:");
      console.log(data.notification);

      var notificationCountElement = document.getElementById("notification-count");
      var notificationCount = notificationCountElement ? parseInt(notificationCountElement.getAttribute("data-count")) : 0;

      notificationCount++;
      if (notificationCountElement) {
        notificationCountElement.setAttribute("data-count", notificationCount);
        notificationCountElement.textContent = notificationCount;
      }

      var notificationList = document.getElementById("notification-list");
      var noNotificationElement = document.getElementById("no-notification");

      if (noNotificationElement) {
        // Hide the "No Notification Yet" message
        noNotificationElement.style.display = "none";
      }

      if (!notificationList) {
        // Create the notification-list element
        notificationList = document.createElement("ul");
        notificationList.id = "notification-list";
        notificationList.className = "dropdown-menu";

        // Append the notification-list element to the existing DOM structure
        var dropdownMenu = document.getElementById("dropdownMenuLink");
        dropdownMenu.appendChild(notificationList);
      }

      var newNotification = document.createElement("li");
      newNotification.className = "notification-message";
      newNotification.textContent = data.message;

      // Check if the first notification in the list
      var isFirstNotification = !notificationList.querySelector(".notification-message");
      
      if (!isFirstNotification) {
        // Add a divider if it's not the first notification
        var divider = document.createElement("div");
        divider.className = "dropdown-divider";
        notificationList.appendChild(divider);
      }

      notificationList.appendChild(newNotification);
    }
  });
});
