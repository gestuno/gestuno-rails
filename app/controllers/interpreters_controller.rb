class InterpretersController < BaseUsersController

  private

  def user_type
    :interpreter
  end

  def allowed_params
    params.require(:interpreter).permit(:language, :certifications, :bio, :gender, :avatar)
  end
end
