# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

---------------------------------------------------------------------------------------

<div class="notification me-3">
    <div class="dropdown">
      <a class="btn btn-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
        <% if logged_in? && current_user.notifications.where(status: false).count > 0 %>
          <span id="notification-count" class="badge rounded-pill badge-notification bg-warning" data-count="<%= current_user.notifications.where(status: false).count %>">
            <%= current_user.notifications.where(status: false).count %>
          </span>
        <% else %>
          <span id="notification-count" class="badge rounded-pill badge-notification bg-warning" data-count="0">0</span>
        <% end %>
      </a>
      <% if logged_in? && current_user.notifications.where(status: false).count>0%>
        <ul class="dropdown-menu" style="width:auto;height:auto;overflow:auto" id="notification-list" aria-labelledby="dropdownMenuButton1">
          <button class="btn btn-sm btn-primary mark-read" value="<%= current_user.id %>" id="readbtn">Mark all as read</button>
          <% current_user.notifications.where(status: false).each do |notification| %>
            <li class="notification-message ms-2 me-2"><%= notification.message %></li>
            <div class="dropdown-divider"></div>
          <% end %>
        </ul>
        <% elsif logged_in? && current_user.notifications.where(status: false).count == 0%>
          <ul class="dropdown-menu" style="width:auto;height:auto;overflow:auto" id="notification-list" aria-labelledby="dropdownMenuButton1">
          <button class="btn btn-sm btn-primary mark-read" value="<%= current_user.id %>" id="readbtn">Mark all as read</button>
          <li class="notification-message" id="no-notification">No Notification Yet</li>
          <div class="dropdown-divider"></div>
          </ul>
      <% end %>
  </div>
</div>