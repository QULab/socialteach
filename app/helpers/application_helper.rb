module ApplicationHelper

    ##
    # Returns whether the given course was created by the current user.
    def check_course_belongs_to_current_user(course)

        if current_user.id == @course.creator_id
            return true

        else
            return false
        end
    end
end
