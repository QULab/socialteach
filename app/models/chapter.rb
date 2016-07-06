class Chapter < ActiveRecord::Base

    belongs_to :course
    has_many :activities

    has_and_belongs_to_many :successors,
      class_name: 'Chapter',
      join_table: :chapter_edges,
      foreign_key: :tail_id,
      association_foreign_key: :head_id,
      uniq: true

    has_and_belongs_to_many :predecessors,
      class_name: 'Chapter',
      join_table: :chapter_edges,
      foreign_key: :head_id,
      association_foreign_key: :tail_id,
      uniq: true

    validates :name, :shortname, :tier, :course, presence: true
    validates :tier, numericality: {greater_than_or_equal_to: 0}

    # returns a list of all chapters, that are valid predecessors for this chapter
    def valid_predecessors
      course_chapters = self.course.chapters.to_a
      predecessors = course_chapters.select do |chapter|
        chapter.tier < self.tier
      end
      return predecessors
    end
end