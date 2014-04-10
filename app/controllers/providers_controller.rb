class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy]

  def index
    @providers = Provider.all
  end

  def show
  end

  def new
    @provider = Provider.new
  end

  def edit
  end

  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      redirect_to providers_path, notice: I18n.t('providers.notice.create_successful')
    else
      render action: 'new'
    end
  end

  def update
    if @provider.update(provider_params)
      redirect_to providers_path, notice: I18n.t('providers.notice.update_successful')
    else
      render action: 'edit'
    end
  end

  def destroy
    @provider.destroy

    redirect_to providers_url
  end

  private
    def set_provider
      @provider = Provider.find(params[:id])
    end

    def provider_params
      params.require(:provider).permit(:name)
    end
end
