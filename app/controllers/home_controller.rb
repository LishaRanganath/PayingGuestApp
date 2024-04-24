class HomeController < ApplicationController
  def index
    @pg_buildings=PgBuilding.all
    if (current_user && current_user.role == 'admin' )
      @deactive_count = current_user.admin.owners.where(status: "deactive").count
      @active_count = current_user.admin.owners.where(status: "active").count
    end
  end
end
