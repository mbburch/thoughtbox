class LinksController < ApplicationController
  def index
    if !current_user
      redirect_to root_path
    else
      @links = Link.where(user_id: current_user.id)
    end
  end

  def new
  end

  def create
    link = Link.new(link_params)
    if link.save
      redirect_to links_path
    else
      flash[:notice] = link.errors.full_messages.join(", ")
      render :index
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    link = Link.find(params[:id])
    if link.update(link_params)
      redirect_to links_path
    else
      flash[:notice] = link.errors.full_messages.join(", ")
      redirect_to links_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id, :read)
  end
end