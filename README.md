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


app/shared/_header.html.erb

<% if @current_user.role == 'admin' %>
            
            <li class="nav-item">
              <%= link_to 'Dashboard', admins_path, class: 'nav-link' %>
            </li>
            <li class="nav-item">
              <%= link_to 'Hotel List', hotels_path, class: 'nav-link' %>
            </li>
            <li class="nav-item">
              <%= link_to 'Room List', rooms_path, class: 'nav-link' %>
            </li>  
            <li class="nav-item">
              <%= link_to 'Gallery', galleries_path, class: 'nav-link' %>
            </li>

          <% elsif user_logged_in? %>

            <li class="nav-item">
              <%= link_to 'Hotel List', hotels_path, class: 'nav-link' %>
            </li>
            <li class="nav-item">
              <%= link_to 'Room List', rooms_path, class: 'nav-link' %>
            </li>  
            <li class="nav-item">
              <%= link_to 'Gallery', galleries_path, class: 'nav-link' %>
            </li>

          <% end %>
        
          <% if user_logged_in? %>

            <li class="nav-item">
              <%= link_to 'Logout', session_path, method: :delete, class: 'nav-link' %>
            </li> 
            <li class="nav-item">
              <span class="nav-link disabled text-dark"><%= @current_user.name %> (<%= @current_user.role %>)</span>
            </li>

          <% else %>


          <% end %>


--------------------------------------------------

facebook authentication

app_id = '147146295015325'
app_secret = 'fd4af0d1017be4cfcc22c92eeb3687a0'