class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @address = Address.new
  end

  def comfirm
    customer = current_customer
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    # address_number 1 ご自身の登録した住所の場合
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.name = customer.full_name
      @order.address = customer.address
    elsif  params[:order][:address_number] == "2"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
    elsif  params[:order][:address_number] == "3"
      address_new = customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      redirect_to cart_items_path
    end
    @cart_items = current_customer.cart_items.all
    @total = 0
  end




  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items.each do |cart_item|
      # 取り出したカートアイテムの数繰り返します
      # order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_detail = OrderDetail.new
      order_detail.amount = cart_item.amount
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      # 購入が完了したらカート情報は削除するのでこちらに保存します
      order_detail.price = cart_item.item.price
      # カート情報を削除するので item との紐付けが切れる前に保存します
      order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
    #購入確定後のページ表示
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

private

  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :total_payment, :shipping_cost, :total_payment)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end

end
