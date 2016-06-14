class AddSuccAndPredToActivities < ActiveRecord::Migration
  def change
    create_table :activity_edges, id: false do |t|
      t.belongs_to :head, class_name: "Activity", index: true, foreign_key: "head_id"
      t.belongs_to :tail, class_name: "Activity", index: true, foreign_key: "tail_id"
    end
  end
end
