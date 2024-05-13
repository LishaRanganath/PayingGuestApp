module PgBuildingManager
    class PgBuildingSearching
        def initialize(params, model: PgBuilding)
            @params = params
            @model = model
        end

        def search_buildings
            result = @model.where("name LIKE ?", "%#{@params}%").order("LOWER(name)")
            result
        end
    end
end