class CreateJoinTableMicropostHashtag < ActiveRecord::Migration
  def change
    create_join_table :microposts, :hashtags do |t|
       t.index [:micropost_id, :hashtag_id]
       t.index [:hashtag_id, :micropost_id]
    end
  end
end
