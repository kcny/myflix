class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :video_id, :user_id
      t.integer :postition
      t.timestamps 
    end
  end
end
