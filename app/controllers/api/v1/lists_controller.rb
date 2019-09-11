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

  def index
    client = Client.find(params[:client_id])
    render json: client.lists
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  def update
    client = Client.find(params[:client_id])
    list = client.lists.find(params[:id])
    list.update_attributes({ name: params[:name] })
    render json: list
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  def destroy
    List.destroy(params['id']).destroy
    render json: {}, status: 204
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Invalid ID'}, status: 404
  end

  private

  def list_params
    list_params = params.require(:list).permit(:name, :caretaker_id)
    list_params['client_id'] = params['client_id']
    list_params
  end
end
