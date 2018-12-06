class UserViewsController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index

    @user_type = current_user.interpreter? ? :customer : :interpreter

    per_page = 12
    @page_idx = params[:page] ? params[:page].to_i - 1 : 0
    @page_human = @page_idx + 1

    results = User.all.select { |user| user.public_send("#{@user_type}?") && user.online? } # TODO improve performance

    @users = results # TODO - order and paginate

    @max_page_idx = ((results.count - 1).to_f / per_page).floor
  end

  def edit
    @user = current_user
  end

  def dashboard

  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :language, :certifications, :bio, :email)
  end

end


