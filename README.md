# README

This README would normally document whatever steps are necessary to get the
application up and running.

## recommended to use google chrome or firefox

* Ruby version -> 3.2.1

* Rails version -> 6.1.7.4

* Webpacker Version -> 5.4.4

* Node Version -> 16.20.1

* Yarn Version -> 1.22.19

* database used -> postgresql

* elastic search version -> 7.4.0

## setup instruction:

```bundle && yarn```

**make sure to start elasticsearch server before seeding the database**

```rails db:create```

```rails db:migrate```

```rails db:seed```

## Necessary Accounts

mail id : admin@gmail.com  (admin)
password : admin

mail id : maheshrao2002@gmail.com  (customer)
password : mahesh

<div class="col-lg-4">
      <div class="form-group">
        <%= form.label :hotel_id, class: 'mb-2' %>
        <%= form.select :hotel_id,  options_for_select(Hotel.all.map{|hotel| [hotel.name, hotel.id]},room.hotel_id),{prompt:'Select Hotel'},class: 'form-select form-select-lg' %>
        <% @room.errors.full_messages_for(:hotel_id).each do |message| %>
          <p class="text-danger"><%= message%></p>
        <% end %>
      </div>