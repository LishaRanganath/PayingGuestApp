class HomeController < ApplicationController
  def index
    @pg_buildings=PgBuilding.all
    if (current_user && current_user.role == 'admin' )
      @deactive_count = current_user.admin.owners.where(status: "deactive").count
      @active_count = current_user.admin.owners.where(status: "active").count
    end
    respond_to do |format|
      format.html
      format.js { render json: { active_count: @active_count, deactive_count: @deactive_count } }
    end
  end
end
