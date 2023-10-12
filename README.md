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

```bundle install && yarn install```

**remove babel.config.js file**

```rails webpacker:install && rails webpacker:compile```

**make sure to start elasticsearch server before seeding the database**

```rails db:create```

```rails db:migrate```

```rails db:seed```

## Necessary Accounts

### Super Admin

  email: superadmin@gmail.com

  password: superadmin

### Hotel Admin (for All password is 'password')

  email: monoteladmin@gmail.com
  
  email: accoadmin@gmail.com

  email: fabexpressadmin@gmail.com

  email: dorotoadmin@gmail.com

  email: midlandadmin@gmail.com

  email: plazaadmin@gmail.com

  email: oyoadmin@gmail.com

  email: hilltopadmin@gmail.com

  email: oyoasansoladmin@gmail.com

### Customer id and password

  email: user@gmail.com

  password: 12345

  email: mahesh@gmail.com

  password: 12345

