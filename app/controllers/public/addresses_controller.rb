class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
  end

  def update
  end


  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

end
