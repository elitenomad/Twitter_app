class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index,:edit, :update,:destroy,:following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  #before_action :admin_user,     only: :destroy
  before_action :micropost_build, only: [:index,:edit, :show, 
                :update,:destroy,:following, :followers]
  
  def new
  	@user =  User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # followed_users = @user.followed_users
    # followed_users.each do |user|
    #   @microposts.push(user.microposts)
    # end
  end

  def create
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Twitter App!"
      UserMailer.welcome_email(@user).deliver

      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to signin_path #users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

  # Before filters

    # def signed_in_user
    #   unless signed_in?
    #     store_location
    #     redirect_to signin_url, notice: "Please sign in."
    #   end
    # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def micropost_build
        # Just for the modal
        @micropost ||= current_user.microposts.build
    end
end
