class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
