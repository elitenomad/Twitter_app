class StaticPagesController < ApplicationController
  before_action :micropost_build,  only: [:help,:about,:contact,:terms]

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.all_feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact

  end

  def terms
  end

  def sendemail
    begin
      UserMailer.feedback_mail(params).deliver
      UserMailer.contact_mail(params).deliver
      redirect_to root_path
    rescue
      flash.now[:notice] = "Error in sending email. Please try again"
      redirect_to root_path
    end
      
  end

   private

    def micropost_build
        # Just for the modal
        if signed_in?
          @micropost ||= current_user.microposts.build
        end
    end

end
