module ApplicationHelper
    def admin_can_sign_up?
        current_user && current_user.role == "admin"
    end
end
