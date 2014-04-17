class HandleStock
  def initialize(params)
    @params = params
  end

  def add_quantity
    stock = Stock.find_or_initialize_by(@params.slice(:product_id, :warehouse_id))
    stock.quantity = stock.quantity.to_i + @params[:quantity].to_i

    stock.save
  end
end
