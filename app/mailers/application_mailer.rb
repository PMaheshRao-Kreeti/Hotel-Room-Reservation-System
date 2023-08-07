# frozen_string_literal: true

# Applicationmailer
class ApplicationMailer < ActionMailer::Base
  default from: 'pmahesh.rao@kreeti.com'
  layout 'mailer'
end
