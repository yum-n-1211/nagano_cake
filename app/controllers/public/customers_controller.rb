class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to '/customers/my_page'
  end

  def unsubscribe
    @customer = Customer.find_by(email: params[:email])
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

private
  def cosutomer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :address,
    :postal_code, :telephone_number, :is_active)
  end

end
