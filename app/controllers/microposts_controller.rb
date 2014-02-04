class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      
      hashtag_array = collect_hashtags(@micropost.content)

      if (hashtag_array.size > 0)
         hashtag_array.each do |hash|
            tag = Hashtag.find_by_name(hash)
            if tag.nil?
              @micropost.hashtags.create(name: hash)
            else
              @micropost.hashtags << tag
            end
         end
      end
      
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

   private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def collect_hashtags(content)
       hashtag_array = content.split(" ")
       hashes = []
       hashtag_array.each do |hash|
           if hash.start_with?("#")
              hashes.push(hash.gsub(/[[:punct:]]$/, ''))
           end
       end

       hashes
    end
end