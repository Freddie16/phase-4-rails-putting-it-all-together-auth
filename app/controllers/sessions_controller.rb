class SessionsController < ApplicationController


    skip_before_action :authorize, only: :create

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: { errors: ["Invalid credentials"]}, status: :unauthorized
        end
    end

    def destroy
        user = User.find_by(id: session[:user_id])
        if user 
          session.delete(:user_id)
         else
            render json: { errors: "You are not a user" }, status: :unauthorized
         end

         def authorize
            return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
        end
    end
end
