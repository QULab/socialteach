class Activity < ActiveRecord::Base
	belongs_to :chapter
	has_many :activity_statuses

  belongs_to :content, polymorphic: true

	has_one :feedback, as: :commentable

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

  # Update switch statment as soon as other content classes exist!
  def color
    case content
      when ActivityLecture
        "#428CCA" # blue
      else
        "#577B99" # greyish blue
    end
  end

  def course
    chapter.course
  end
end
