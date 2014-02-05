class HashtagsController < ApplicationController
  before_action :micropost_build

  def show
  	 @hashtag = Hashtag.find(params[:id])
  	 @microposts = @hashtag.microposts.paginate(page: params[:page])
  end

  def index
  	@hashtags = Hashtag.all
  end

  def search
  	@results = Hashtag.where(['name like ?', params[:tag] + '%']).limit(10)
  end


  private

    def micropost_build
        # Just for the modal
        @micropost ||= current_user.microposts.build
    end

end
