class ClientRecordsController < ApplicationController
  before_action :set_client
  before_action :set_client_record, only: [:edit, :create, :update]

  def new
    @title = "New records for #{@client.name}"
    @client_record = ClientRecord.new
  end

  def create
    @client_record = ClientRecord.new(allowed_params)
    @client_record.client = @client
    @client_record.save
  end

  def edit
    @title = "Updating records for #{@client.name}"
  end

  def update
    @client_record.update_attributes(allowed_params)
  end

  private

  def allowed_params
    params.require(:client_record).permit!
  end

  def set_client_record
    @client_record = @client.client_records.where(id: params[:id]).first
  end

  def set_client
    @client = Client.includes(:client_records).find(params[:client_id])
  end
end
