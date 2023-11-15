# frozen_string_literal: true

# Notification modal handle notifications of user
class Notification < ApplicationRecord
  belongs_to :user
  validates :message, presence: true
  validates :status, presence: true
end
