class Admin::ClientsController < ApplicationController
  def index
    @clients = Client.all.order('created_at ASC')
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
    @client = Client.find(params[:id])
    @title = "Updating #{@client.name.titleize}"
  end

  def update
    @client = Client.find(params[:id])
    @client.update_attributes(allowed_params)
  end

  private

  def allowed_params
    params.require(:client).permit!
  end
end
