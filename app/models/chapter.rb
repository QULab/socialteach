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

    def progress(course_enrollment)
      total_activities = self.activities.count
      finished_activities = course_enrollment.activity_statuses.where(activity_id: self.activities.select(:id), is_completed: true, status: 1).select(:activity_id).distinct.count
      if (total_activities > 0)
        percent = finished_activities.to_f / total_activities.to_f * 100
      else
        percent = 100
      end
      return {:total_activities => total_activities, :finished_activities => finished_activities, :percent => percent}
    end
end
