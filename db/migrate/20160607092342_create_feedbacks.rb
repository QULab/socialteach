class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :commentable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
