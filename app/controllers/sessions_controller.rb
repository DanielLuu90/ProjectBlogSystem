class SessionsController < ApplicationController
  def new
  end

  def create
	user = User.find_by_email(params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
		log_in user
		remember(user) if params[:session][:remember_me] == 1
		redirect_to user
	  else
	  	render 'new'
	  	flash[:danger] = 'Invalid email/password combination'
	end
	
  end

  def destroy
  	log_out if logged_in?
    log_out
    redirect_to root_url
  end
end
