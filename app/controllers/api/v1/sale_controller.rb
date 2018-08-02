class Api::V1::SaleController < ApplicationController
    def index
        render json: { status: "OK"}
    end
    
    private 
    def sale_params
        params.permit(:id,:product_code,:quantity,:price,:currency_code,:sale_date)
    end
end
