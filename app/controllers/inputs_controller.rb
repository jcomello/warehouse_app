class InputsController < ApplicationController
  def index
    @inputs = Input.all
  end

  def new
    @input = Input.new
  end

  def create
    @input = Input.new(input_params)
    @input.employee = current_employee

    if @input.save
      set_product_at_stock

      redirect_to inputs_path, notice: I18n.t('inputs.notice.create_successful')
    else
      render action: 'new'
    end
  end

  private

  def input_params
    params.require(:input).permit(:quantity, :product_id, :warehouse_id)
  end

  def set_product_at_stock
    @stock = Stock.find_or_initialize_by(
                     product_id: input_params[:product_id],
                     warehouse_id: input_params[:warehouse_id])

    @stock.quantity = @stock.quantity.to_i + input_params[:quantity].to_i
    @stock.save
  end
end
