module CoursesHelper
    def get_username(duell)
    	number = duell.challenger_id.to_i
    	return User.find(number).username
    end

    def get_activity(duell)

    	return Activity.where(content: duell)[0].id
    end
    def get_activity_status(duell)
    	if duell.enemy_bool == false && duell.challenger_bool ==true 
    		return false
    	else
    		true
    	end
    end
end
