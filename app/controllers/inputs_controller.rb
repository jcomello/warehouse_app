class InputsController < ApplicationController
  def index
    @inputs = Input.all
  end
end
