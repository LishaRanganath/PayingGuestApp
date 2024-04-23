class HomeController < ApplicationController
  def index
    @pg_buildings=PgBuilding.all
  end
end
