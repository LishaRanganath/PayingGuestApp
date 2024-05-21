module PgBuildingManager
    class PgBuildingFiltering
        def initialize(params, model: PgBuilding)
            @params = params
            @model = model
        end
    
        def filter_buildings
            filter_by_order_type
            filter_by_room_query
            filter_by_category_query
            @model.distinct
        end
    
        private
    
        def filter_by_order_type
            order_type = @params[:query]
            @model = @model.order(name: order_type) if order_type.present?
        end
    
        def filter_by_room_query
            room_query = @params[:room_query]
            @model = @model.joins(:room_types).where("room_types.name LIKE ?", "%#{room_query}%") if room_query.present?
        end
    
        def filter_by_category_query
            category_query = @params[:category_query]
            @model = @model.joins(:categories).where("categories.name LIKE ?", "%#{category_query}%") if category_query.present?
        end
    end
end