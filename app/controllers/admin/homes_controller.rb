class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page])
  end


  private
  def order_params
    require.(:order).permit(:status)
  end

end
