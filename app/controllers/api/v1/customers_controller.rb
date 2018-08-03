class Api::V1::CustomersController < ApplicationController
    def index
        render json: Customer.all()
    end

    def create 
        begin
            c = Customer.new()
            c.customer_code = customer_params[:customer_code]
            c.gender = customer_params[:gender]
            c.fullname = customer_params[:fullname]
            c.dateOfBirth = customer_params[:dateOfBirth]
            c.current_addr = customer_params[:current_addr]
            c.province_code = customer_params[:province_code]
            c.registered_date = customer_params[:registered_date]
            c.tel = customer_params[:tel]
            c.mobile = customer_params[:mobile]
            c.email = customer_params[:email]
            c.fb = customer_params[:fb]
            c.socials = customer_params[:socials]

            Customer.transaction do 
                c.save
                render json: c
            end
        rescue => exception
            render json: exception
        end
    end

    private 
    def customer_params 
        params.permit(:id,:customer_code,:gender,:fullname,:dateOfBirth,:current_addr,:province_code,
            :registered_date,:tel,:mobile,:email,:fb,:socials)
    end
end
