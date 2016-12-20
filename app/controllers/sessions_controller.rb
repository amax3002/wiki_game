class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:email]

    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      flash[:success] = "Successfully logged in!"
      if @user.cakewalker?
        redirect_to orders_path
      else
        redirect_to products_path
      end
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete("current_user_id")
    redirect_to root_path
  end
end
