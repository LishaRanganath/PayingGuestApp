module HomeHelper
    def filtered_pg_buildings(pg_buildings, current_user)
        filtered_buildings = []
    
        pg_buildings.each do |building|
          if building.owner.status == "active" && building.owner.admin == current_user.admin
            filtered_buildings << building
          end
        end
    
        filtered_buildings
    end

    def all_pg_buildings_customer(pg_buildings,current_user)
        all_buildings = []

        pg_buildings.each do |building|
            if building.owner.status == "active"
                all_buildings << building
            end
        end
        all_buildings
    end 

    def all_pg_buildings_owner(pg_buildings,current_user)
        all_buildings = []

        pg_buildings.each do |building|
            if building.owner_id == current_user.owner.id && current_user.owner.status == "active"
                all_buildings << building
            end
        end

        all_buildings
    end

    def building_image_tag(building)
        if building.image.present?
            image_tag url_for(building.image), class: "image"
        else
            content_tag :p, "No image available", class: "no_image", style: "padding-left:20%;"
        end
    end

    def active_buildings_count(current_user)
        count=0
        current_user.admin.owners.each do |owner|
            if owner.status == "active"
                count += owner.pg_buildings.count
            end
        end
        count
    end

    def modal_title_based_on_role(current_user)
        if current_user && current_user.role == "admin"
           "Add Building"
        else
            "Add Owner"
        end
    end
    
    def render_patial_based_on_role(current_user)
        if current_user && current_user.role == "admin"
            render partial: "owners/form", locals: { owner: Owner.new, path: owners_path, method: :post } 
        else
            render partial: "pg_buildings/new"
        end
    end
end
