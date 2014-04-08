class WarehousesController < ApplicationController
  def index

  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_parameters)

    if @warehouse.save
      redirect_to warehouses_path
    else
      render :new
    end
  end

  private

  def warehouse_parameters
    params.require(:warehouse).permit(:street, :number)
  end
end
