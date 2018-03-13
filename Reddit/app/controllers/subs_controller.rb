class SubsController < ApplicationController
  before_action :require_log_in
  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def create
    @sub = Sub.new(sub_params)

    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = current_user.moderated_subs.find(params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub.moderator == current_user
      @sub.destroy
      redirect_to subs_url
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
