# frozen_string_literal: true

# Welcome controller is a root page that show button for login
class WelcomeController < ApplicationController
  def index
    # show welcome page with login and sign up button
    return unless user_logged_in?

    if current_user.customer?
      redirect_to customers_path
    else
      redirect_to admins_path
    end
  end

  def customer_index; end
  def gallery; end
end
