class Api::V1::LinksController < ApplicationController
  respond_to :json

  def update
    @link = Link.find(params[:id])
    respond_with @link.update(params[:id], link_params)
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id, :read)
  end

end