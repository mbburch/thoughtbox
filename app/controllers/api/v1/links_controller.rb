class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    if current_user
      respond_with current_user.links
    else
      redirect_to root_path
    end
  end

  def update
    respond_with Link.update(params[:id], link_params)
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id, :read)
  end

end