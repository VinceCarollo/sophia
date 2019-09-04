class Api::V1::ListsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    new_list = List.new(list_params)
    if new_list.save
      render json: new_list, status: 201
    else
      render json: new_list.errors, status: 404
    end
  end

  private

  def list_params
    jeremey = params.require(:list).permit(:name)
    jeremey['client_id'] = params['client_id']
    jeremey
  end
end
