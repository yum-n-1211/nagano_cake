class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  # カートに商品を追加する
  def create
  # 1. 追加した商品がカート内に存在するかの判別
    if @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
  #2. カート内の個数をフォームから送られた個数分追加する
      @cart_item.amount += params[:cart_item][:amount].to_i
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
    end
    @cart_item.save
    redirect_to cart_items_path
  end


  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:amount])
    redirect_to cart_items_path
  end


  # カートを空にする
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  # カートに入れた商品を削除
  def destroy
    @cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
