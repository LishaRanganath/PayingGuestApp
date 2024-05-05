module OwnerHelper
    def render_action_buttons(owner)
        if owner.status == "deactive"
            content_tag(:td) do
                button_to 'Activate', activate_owner_path(owner), class: 'btn links', method: :post
            end +
            content_tag(:td) do
                button_tag 'Deactivate', class: 'btn disabled', disabled: true
            end
        else
            content_tag(:td) do
                button_tag 'Activate', class: 'btn disabled', disabled: true
            end +
            content_tag(:td) do
                button_to 'Deactivate', deactivate_owner_path(owner), class: 'btn links', method: :post
            end
        end
    end
end
