module Records
  class ClientCleanup
    def initialize
      @clients = Client.all
    end

    def clean
      cleanup_name
      cleanup_duplicates
    end

    private

    def cleanup_name
      update_hash = Hash.new
      @clients.each do |client|
        update_hash[client.id] = { name: client.name.upcase }
      end
      Client.update(update_hash.keys, update_hash.values)
    end

    def cleanup_duplicates
      @clients.uniq { |client| [client.name, client.birthdate] }.each do |client|
        duplicates = @clients.where(name: client.name).where.not(id: client.id)
        next unless duplicates.any?
        duplicates.map(&:client_records).flatten.each do |client_record|
          client_record.update(client: client)
        end
        duplicates.each { |dup| dup.reload.destroy }
      end
    end
  end
end
