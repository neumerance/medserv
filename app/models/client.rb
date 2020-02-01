class Client < ApplicationRecord
  attr_accessor :country_dial_code

  has_many :client_records, dependent: :destroy
  validates :name, :birthdate, :contact_number, :occupation, presence: true
  validates :name, uniqueness: true

  scope :search_by_name, -> (name) { where("name ILIKE ?", "%#{name.upcase}%") }
  scope :search_by_birthdate, -> (date) { where(birthdate: date) }
  scope :order_by_creation, -> () { order('created_at DESC') }

  before_save :upcase_name

  def self.filter(filters)
    clients = includes(:client_records).order_by_creation
    clients = clients.search_by_name(filters[:name]) if filters[:name].present?
    clients = clients.search_by_birthdate(filters[:birthdate]) if filters[:birthdate].present?
    clients
  end

  def latest_medical_record
    medical_records.first
  end

  def medical_records
    client_records.order('created_at DESC')
  end

  private

  def append_country_dial_code
    self.contact_number = "+#{country_dial_code}#{contact_number}"
  end

  def upcase_name
    return unless self.name.present?
    self.name = self.name.upcase
  end
end
