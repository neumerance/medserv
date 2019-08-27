class Admin::ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update]
  add_breadcrumb 'Clients', :admin_clients_path

  def index
    @clients = Client.filter(filter_params)
    respond_to do |f|
      f.js
      f.html
    end
  end

  def show
    add_breadcrumb @client.name.titleize, admin_client_path(id: @client.id)
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

  def filter_params
    params[:filters] ||= {}
  end
end
