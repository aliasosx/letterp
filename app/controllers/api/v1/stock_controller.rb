class Api::V1::StockController < ApplicationController
    def index 
        render json: { status: "OK"}
    end
    def update 
        # update stock quantity
        begin
            @stock = Stock.find_by(product_code: stock_params[:product_code])

            puts json: @stock
            @stock.current_stock = stock_params[:current_stock]
            @stock.update_by = stock_params[:update_by]
            ActiveRecord::Base.transaction do 
                StockTracking.where(product_code: stock_params[:product_code]).last(1).each do |stock_tracking|
                    stock_tracking.update(old_quantity: stock_tracking.current_quantity , current_quantity: stock_params[:current_stock], description: 'admin',transxlogid: SecureRandom.uuid)
                end 
                @stock.save
                render json: { status: 'Saved' , data: @stock.current_stock }
            end
        rescue => exception
            render json: exception
        end
    end

    private
    def stock_params
        params.permit(:id,:product_code,:stock_date,:init_stock,:current_stock,:update_by)
    end
end
