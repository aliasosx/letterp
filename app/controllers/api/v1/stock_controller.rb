class Api::V1::StockController < ApplicationController
    def index 
        render json: { status: "OK"}
    end
    def show
        @stock = Stock.where
    end 

    private
    def stock_params
        params.permit(:id,:)
    end
end
