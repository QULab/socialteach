class AddSuccAndPredToChapters < ActiveRecord::Migration
  def change
    create_table :chapter_edges, id: false do |t|
      t.belongs_to :head, class_name: "Chapter", index: true, foreign_key: "head_id"
      t.belongs_to :tail, class_name: "Chapter", index: true, foreign_key: "tail_id"
    end
  end
end
