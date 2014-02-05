class SessionsController < ApplicationController

	def new
	end

	def create
		#render 'new'
		@user = User.find_by_email(params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			sign_in @user
			#flash[:success] = "Welcome to the Sample App!"
      		#redirect_to @user
      		redirect_back_or @user
		else
			flash.now[:error] = 'Invalid email/password combination' # Not quite right!
			render 'new'
		end
	end

	def destroy
		sign_out
    	redirect_to root_url
	end

	private

    def micropost_build
        # Just for the modal
        if signed_in?
          @micropost ||= current_user.microposts.build
        end
    end
end
