class ClientRecord < ApplicationRecord
  belongs_to :client
  validates :systolic, :diastolic, :heart_rate, presence: true
end
