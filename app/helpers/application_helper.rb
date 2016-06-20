module ApplicationHelper
    
    def check_course_belongs_to_current_user(course)
       
        if current_user.id == @course.creator_id
            return true
            
        else
            return false
        end
    end
end
