class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:edit, :update, :destroy]

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
      redirect_to warehouses_path, notice: I18n.t('warehouses.notice.create_successful')
    else
      render action: :new
    end
  end

  def update
    if @warehouse.update(warehouse_parameters)
      redirect_to warehouses_path, notice: I18n.t('warehouses.notice.update_successful')
    else
      render action: :edit
    end
  end

  def destroy
    @warehouse.destroy

    redirect_to warehouses_path
  end

  private

  def warehouse_parameters
    params.require(:warehouse).permit(:street, :number, :complement, :cep)
  end

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
