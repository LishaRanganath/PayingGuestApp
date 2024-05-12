class CategoriesController < ApplicationController
    def create
        building =PgBuilding.find_by(id: category_params[:pg_building_id])
        category_type = building.categories.create(category_params).save
        if category_type
            redirect_to pg_building_path(id: building.id), notice: "The room category was created sucessfully"
        else
            redirect_to pg_building_path(id: building.id), notice: "The room category could not be created"
        end
    end

    def destroy
        category_type=Category.find_by(id: params[:id]).destroy
        if category_type
            redirect_to pg_building_path(id: category_type.pg_building.id), notice: "Category Type was deleted"
        else
            redirect_to pg_building_path(id: category_type.pg_building.id), notice: "Category Type could not be deleted"
        end

    end

    def edit
        @category_type = Category.find_by(id: params[:id])
    end

    def update
        category_type=Category.find_by(id: params[:id])
        category_type.update(category_params)
        if category_type.save
            redirect_to pg_building_path(id: category_type.pg_building.id), notice: "Category Type Updated Sucessfully"
        else
            redirect_to pg_building_path(id: category_type.pg_building.id), notice: "Could Not Update Category Type"
        end
    end

    private

    def category_params
        params.require(:category).permit(:name,:price, :pg_building_id)
    end

end
