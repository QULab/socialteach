class Comment < ActiveRecord::Base
	acts_as_tree order: 'created_at DESC'
	belongs_to :course
	belongs_to :activity
end
