class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer

# 小計
  def subtotal
    item.add_tax_price * amount
  end

end
