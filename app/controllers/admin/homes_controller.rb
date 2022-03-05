class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page])
  end


  private
  def order_params
    require.(:order).permit(:status)
  end

end
