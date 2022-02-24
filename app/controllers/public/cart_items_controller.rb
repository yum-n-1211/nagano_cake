class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new
  end




  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
