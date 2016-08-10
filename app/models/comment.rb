##
# Represents a comment of course
# Could be used for user activities or chapters if prefered
# Structures as a tree for reason to have sub comments
class Comment < ActiveRecord::Base
	acts_as_votable
	acts_as_tree order: 'cached_votes_up DESC'
	#acts_as_tree order: 'created_at DESC'
	belongs_to :course
	belongs_to :activity
end
