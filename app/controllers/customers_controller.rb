class CustomersController < BaseUsersController

  private

  def user_type
    :customer
  end

  def allowed_params
    # params.require(:customer).permit(:language, :bio, :gender)
    params.require(:customer).permit(:gender, :language)
  end
end
