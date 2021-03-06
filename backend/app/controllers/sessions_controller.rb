class SessionsController < ApplicationController
  include AuthenticationConcern
  # protect_from_forgery with: :exception

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to user_path(user.id)
    else
      if user.nil?
        render json: { :error => "That username does not exist." }
      else
        render json: { :error => "That password is invaid." }
      end
    end
  end

  def show
    @user = current_user
    render partial: 'show'
  end

  def destroy
    logout
    redirect_to root_path
  end

end
