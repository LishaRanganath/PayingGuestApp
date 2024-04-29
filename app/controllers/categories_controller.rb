class CategoriesController < ApplicationController
    def create
        building =PgBuilding.find_by(params[:id])
        category_type = building.categories.create(category_params)
        if category_type.save
            redirect_to root_path, notice: "The room category was created sucessfully"
        else
            redirect_to root_path, notice: "The room category could not be created"
        end
    end


    private

    def category_params
        params.require(:category).permit(:name,:price)
    end

end
