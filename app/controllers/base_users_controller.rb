 class BaseUsersController < ApplicationController
  # TODO: DRY up with base user controller class

  def index
    per_page = 12
    @page_idx = params[:page] ? params[:page].to_i - 1 : 0
    @page_human = @page_idx + 1

    results = User.all.select { |user| user.public_send("#{user_type}?") && user.online? } # TODO improve performance

    instance_variable_set(
      "@#{user_type}s",
      # results.order(:last_seen).limit(per_page).offset(per_page * @page_idx)
      results # TODO - order and paginate
    )

    @max_page_idx = ((results.count - 1).to_f / per_page).floor
  end

  def show
    instance_variable_set("@#{user_type}", User.find(params[:id]))
  end

  def edit
    # TODO pundit - check if current_user, then...
    instance_variable_set("@#{user_type}", User.find(params[:id]))
  end

  def update
    # TODO pundit - check if current_user, then...
    user = User.find(params[:id])

    if user.update(allowed_params)
      # render "#{user_type}s/#{user.id}"
      redirect_to :root # ??
    else
      render :edit # ??
    end
  end
end
