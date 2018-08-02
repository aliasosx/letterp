class Api::V1::ProductCategoriesController < ApplicationController
    def index()
        render json: ProductCategory.all()
    end
    def create()
        @productCat = ProductCategory.create(prod_cat_code:product_category_params[:prod_cat_code],
            prod_cat_name_en:product_category_params[:prod_cat_name_en],prod_cat_name_la:product_category_params[:prod_cat_name_la])
        
        render json: {success: 'ok'}
    end
    private 
    def product_category_params()
        params.permit(:id,:prod_cat_code,:prod_cat_name_en,:prod_cat_name_la)
    end
end