module PgBuildingManager
    class PgBuildingService
        def initialize(params)
            @params = params
        end
    
        def filter_buildings
            filter = PgBuildingFiltering.new(@params)
            filter.filter_buildings
        end
        def search_buildings
            search = PgBuildingSearching.new(@params)
            search.search_buildings
        end
    end
end