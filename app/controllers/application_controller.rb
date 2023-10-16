# frozen_string_literal: true

# ApplicationContoller
class ApplicationController < ActionController::Base
  include ApplicationHelper
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end
end
