class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:edit, :update]

  def index
    @warehouses = Warehouse.all
  end

  def edit
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_parameters)

    if @warehouse.save
      redirect_to warehouses_path
    else
      render action: :new
    end
  end

  def update
    if @warehouse.update(warehouse_parameters)
      redirect_to warehouses_path, notice: 'Almoxarifado atualizado com sucesso'
    else
      render action: :edit
    end
  end

  private

  def warehouse_parameters
    params.require(:warehouse).permit(:street, :number)
  end

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
