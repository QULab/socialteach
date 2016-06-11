module ApplicationHelper
    
    def check_if_user_is_constructor
       
        if current_user.is_instructor? and user_signed_in?
            return true;
        else 
            return false
        end
    end
end
