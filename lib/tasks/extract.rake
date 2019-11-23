require 'csv'

namespace :extract do
  desc 'Extracts client contacts to csv'
  task clients: :environment do
    clients = Client.joins(:client_records).
      select(:id, :name, :contact_number).
      group('client_records.client_id, clients.id, clients.name, clients.contact_number').
      having('COUNT(client_records.client_id) > 1')

    CSV.open(Rails.root.join('tmp/contact.csv'), "wb") do |csv|
      clients.to_a.each do |client|
        phone = client.contact_number.gsub('+65', '')
        next unless phone.size == 8
        csv << [phone, client.name, 65]
      end
    end
  end
end
