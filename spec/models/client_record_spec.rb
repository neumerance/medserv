require 'rails_helper'

RSpec.describe ClientRecord, type: :model do
  it { should belong_to(:client) }
  it { should validate_presence_of(:systolic) }
  it { should validate_presence_of(:diastolic) }
  it { should validate_presence_of(:heart_rate) }
end
