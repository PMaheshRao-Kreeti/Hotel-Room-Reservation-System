# frozen_string_literal: true

# Applicationmailer
class ApplicationMailer < ActionMailer::Base
  default from: 'raomahesh416@gmail.com'
  layout 'mailer'
end
