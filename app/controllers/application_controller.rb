class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorize


  private

  def authorize
    user = User.find_by(id: session[:user_id])
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end

end
