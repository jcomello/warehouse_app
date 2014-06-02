class InputsController < ApplicationController
  def index
    @inputs = Input.search(params)
  end

  def new
    @input = Input.new
  end

  def create
    @input = Input.new(input_params)
    @input.employee = current_employee

    if @input.save
      HandleStock.new(input_params).add_quantity

      redirect_to inputs_path, notice: I18n.t('inputs.notice.create_successful')
    else
      render action: 'new'
    end
  end

  private

  def input_params
    params.require(:input).permit(:quantity, :product_id, :warehouse_id)
  end
end
