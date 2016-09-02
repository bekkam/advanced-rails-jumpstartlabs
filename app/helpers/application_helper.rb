module ApplicationHelper

    def current_user_is_admin?
        params[:admin] == true ? true : false
    end
end
