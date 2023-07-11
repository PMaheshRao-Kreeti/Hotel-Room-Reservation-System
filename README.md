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

----------------------------------------------------
app/views/hotels/index.html.erb
            
            <div class="col-lg-3">
              <% room_count(hotel) %>
              <p class="card-text"><strong>Room Available:</strong></p>
              <p class="card-text">Single Bedroom :<%= @single_bedroom_count %> Available</p>
              <p class="card-text">Double Bedroom :<%= @double_bedroom_count %> Available</p>
              <p class="card-text">Suite :<%= @suite_count %> Available</p>
              <p class="card-text">Dormitory :<%= @dormitory_count %> Available</p>
            </div>