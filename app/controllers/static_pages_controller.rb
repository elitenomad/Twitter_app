class StaticPagesController < ApplicationController
  before_action :micropost_build,  only: [:help,:about,:contact]

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact

  end

  def sendemail
    UserMailer.contact_mail(params).deliver
    redirect_to root_path
  end

   private

    def micropost_build
        # Just for the modal
        if signed_in?
          @micropost ||= current_user.microposts.build
        end
    end

end
