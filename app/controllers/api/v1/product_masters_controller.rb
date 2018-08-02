class Api::V1::ProductMastersController < ApplicationController
    def index
        render json: ProductMaster.all()
    end
    def show
        if ProductMaster.exists?(products_param[:id])
            @products = ProductMaster.where(id:products_param[:id])
            render json: @products
        else 
            render json: { status: 'Not existing records' }
        end
    end

    def create 
        begin
            p = ProductMaster.new()
            p.product_code = products_param[:product_code]
            p.product_barcode = products_param[:product_barcode]
            p.product_serial_number = products_param[:product_serial_number]
            p.product_name = products_param[:product_name]
            p.manufacture_date = products_param[:manufacture_date]
            p.expire_date = products_param[:expire_date]
            p.cost_price = products_param[:cost_price]
            p.starting_quantity = products_param[:starting_quantity]
            p.stock_in_date = products_param[:stock_in_date]
            p.minimun_quantity = products_param[:minimun_quantity]
            p.save
            render json: { status: 'OK'}
        rescue => exception
            render json: { status: exception}
        end       
    end
    def update
        begin
            p = ProductMaster.find_by(id:products_param[:id])
            p.product_name = products_param[:product_name]
            p.save
            render json: { status: 'Record updated'}
        rescue => exception
            render json: { status: exception}
        end
    end  
    def destroy
        begin
            p = ProductMaster.find(products_param[:id])
            p.destroy
            render json: { status: 'Record Deleted'}
        rescue => exception
            render json: { status: exception}
        end
    end

        private 
    def products_param
        params.permit(:id,:product_code,:product_barcode,:product_serial_number,:product_name,:manufacture_date,
            :expire_date,:cost_price,:starting_quantity,:minimun_quantity,:stock_in_date)
    end
end

