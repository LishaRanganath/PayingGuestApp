class PgBuildingController < ApplicationController
  def index
    @owner=Owner.find_by(id: params[:id])
    @pg_buildings=@owner.pg_buildings
  end
end
