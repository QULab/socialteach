class Activity < ActiveRecord::Base
	belongs_to :chapter

  belongs_to :content, polymorphic: true

  has_and_belongs_to_many :successors,
    class_name: 'Activity',
    join_table: :activity_edges,
    foreign_key: :tail_id,
    association_foreign_key: :head_id,
    uniq: true

  has_and_belongs_to_many :predecessors,
    class_name: 'Activity',
    join_table: :activity_edges,
    foreign_key: :head_id,
    association_foreign_key: :tail_id,
    uniq: true

  validates :name, :shortname, :tier, :chapter, presence: true
  validates :tier, :levelpoints, numericality: {greater_than_or_equal_to: 0}

  # Create a switch statment as soon as sub classes exist!
  def color
    "#000000"
  end
end
