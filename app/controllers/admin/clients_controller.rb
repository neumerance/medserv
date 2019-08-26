class Admin::ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update]

  def index
    @clients = Client.all.includes(:client_records).order('created_at ASC')
  end

  def show
    @title = "Client #{@client.name.titleize}"
  end

  def new
    @title = 'Create new client'
    @client = Client.new
  end

  def create
    @client = Client.new(allowed_params)
    @client.save
  end

  def edit
    @title = "Updating #{@client.name.titleize}"
  end

  def update
    @client.update_attributes(allowed_params)
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def allowed_params
    params.require(:client).permit!
  end
end
