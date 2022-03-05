class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum making_status: { cannot:0, wait:1, manufucture:2, complete:3 }

  def add_tax_price
    (price * 1.1).floor
  end

  def subtotal
    add_tax_price * amount
  end

end
