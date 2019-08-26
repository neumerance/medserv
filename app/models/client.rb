class Client < ApplicationRecord
  has_many :client_records
  validates :name, :birthdate, :contact_number, :occupation, presence: true

  scope :search_by_name, -> (name) { where("name ILIKE ?", "%#{name}%") }
  scope :search_by_birthdate, -> (date) { where(birthdate: date) }
  scope :order_by_creation, -> () { order('created_at DESC') }

  def self.filter(filters)
    clients = includes(:client_records).order_by_creation
    clients = clients.search_by_name(filters[:name]) if filters[:name].present?
    clients = clients.search_by_birthdate(filters[:birthdate]) if filters[:birthdate].present?
    clients
  end
end
