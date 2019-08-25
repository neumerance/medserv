class Client < ApplicationRecord
  has_many :client_records
  validates :name, :birthdate, :contact_number, :occupation, presence: true
end
