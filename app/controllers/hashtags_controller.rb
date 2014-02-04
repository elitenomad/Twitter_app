class HashtagsController < ApplicationController
  def show
  	 @hashtag = Hashtag.find(params[:id])
  	 @microposts = @hashtag.microposts.paginate(page: params[:page])
  end



end
