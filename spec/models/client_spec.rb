require 'rails_helper'

describe Client, type: :model do
  it { should have_many(:client_records) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:birthdate) }
  it { should validate_presence_of(:contact_number) }
  it { should validate_presence_of(:occupation) }
end
