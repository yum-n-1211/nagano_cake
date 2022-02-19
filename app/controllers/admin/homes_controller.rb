class Admin::HomesController < ApplicationController
  def top
    @order = Order.page(params[:page])
  end
  
  
  private
  def order_params
    require.(:order).permit(:created_at, :customer_id, :)
  end
  
end
