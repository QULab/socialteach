module CoursesHelper
    def get_username(duell)
        # getting the name of the challenger of the duell
    	number = duell.challenger_id.to_i
    	return User.find(number).username
    end

    def get_activity(duell)
        # getting the activity of the duell (because the duell is the content of that activity)
    	return Activity.where(content: duell)[0].id
    end

    def get_activity_status(duell)
        # checking if the duell is already completed
    	if duell.enemy_bool == false && duell.challenger_bool ==true
    		return false
    	else
    		true
    	end
    end

    def filterAct(activ,user)
        # filtering for the activities without the false duells
        activity=activ.activities.order("tier ASC")
        duells = activ.activities.where(content_type:ActivityDuell)
        result = duells.select do |act|
            act.content.enemy_id != user.id && act.content.challenger_id != user.id
        end
        tmp = activity - result
        return tmp
    end
end
