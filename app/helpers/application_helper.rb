module ApplicationHelper
    def admin_log_in?
        current_user && current_user.role == "admin"
    end
    def owner_log_in?
        current_user && current_user.role == "owner"
    end
end
