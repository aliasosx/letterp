class Api::V1::StockController < ApplicationController
    def index 
        render json: { status: "OK"}
    end
end
