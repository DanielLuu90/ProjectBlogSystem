module SessionsHelper
	def log_in user
		cookies.permanent[:remember_token] = user.remember_token
		session[:user_id] = user.id
	end
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	def logged_in?
		!session[:user_id].nil?	
	end
	def remember user
		cookies.permanent.signed[:user_id] = used.id
		cookies.remember_token.signed[:remember_token]= user.remember_token
	end
	def current_user
		if user_id = session[:user_id]
			@current_user ||= User.find_by id: user_id
		elsif user_id = cookies.signed[:user_id]
			user = User.find_by id: user_id
			if user && user.authenticate?(:remember, cookies[:remember_token])
					log_in user
					@current_user = user				
			end
			
		end
	end
	
	def current_user? user
		user == current_user
	end
end

	
