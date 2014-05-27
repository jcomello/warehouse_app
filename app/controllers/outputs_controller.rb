class OutputsController < ApplicationController
  def index
    @outputs = Output.all
  end

  def new
    @output = Output.new
  end

  def create
    @output = Output.new(output_params)
    @output.employee = current_employee

    @handle_stock = HandleStock.new(output_params)

    if @output.valid?
      if @handle_stock.deacrease_quantity
        @output.save
        redirect_to new_output_path, notice: I18n.t('outputs.notice.create_successful')
      else
        flash.now[:alert] = @handle_stock.errors[:quantity]
        render action: :new
      end
    else
      render action: :new
    end
  end

  private

  def output_params
    params.require(:output).permit(:quantity, :product_id, :warehouse_id)
  end
end
