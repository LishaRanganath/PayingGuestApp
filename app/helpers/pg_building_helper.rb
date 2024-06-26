module PgBuildingHelper
    def is_owner?
        current_user && current_user.owner?
    end

    def building_image_tag(building)
        if building.image.present?
            image_tag url_for(building.image), class: "image"
        else
            content_tag :p, "No image available", class: "no_image", style: "padding-left:20%;"
        end
    end

    def render_room_types(room_types)
        room_types.map do |room|
          content_tag(:tr) do
            concat content_tag(:td, room.name)
            concat content_tag(:td, room.price)
            concat content_tag(:td, link_to('Update', edit_room_type_path(id: room.id), class: 'btn'))
            concat content_tag(:td, button_to('Delete', room_type_path(id: room.id), class: 'btn', method: :delete))
          end
        end.join.html_safe
    end

    def render_categories(categories)
        categories.map do |category|
            content_tag(:tr) do
            concat content_tag(:td, category.name)
            concat content_tag(:td, category.price)
            concat content_tag(:td, link_to('Update', edit_category_path(id: category.id), class: 'btn'))
            concat content_tag(:td, button_to('Delete', category_path(id: category.id), class: 'btn', method: :delete))
            end
        end.join.html_safe
    end

   
end
