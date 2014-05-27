class HandleStock
  attr_accessor :errors

  def initialize(params)
    @params = params
  end

  def add_quantity
    stock = Stock.find_or_initialize_by(@params.slice(:product_id, :warehouse_id))
    stock.quantity = stock.quantity.to_i + @params[:quantity].to_i

    stock.save
  end

  def deacrease_quantity
    stock = Stock.find_or_initialize_by(@params.slice(:product_id, :warehouse_id))
    stock.quantity = stock.quantity.to_i - @params[:quantity].to_i

    stock.valid? || (@errors = stock.errors.messages)
    stock.save
  end
end
