class ClientRecord < ApplicationRecord
  belongs_to :client
  validates :systolic, :diastolic, :heart_rate, :weight, presence: true

  def blood_pressure
    "#{systolic}/#{diastolic}"
  end

  def has_todays_record?
    created_at < Time.now.end_of_day
  end
end
