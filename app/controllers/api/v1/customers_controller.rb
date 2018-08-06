class Api::V1::CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :edit, :update, :destroy]
    def index
        @customer = Customer.all()
        render json: @customer
    end

    def create 
        begin
            @customer = Customer.new(customer_params)
            Customer.transaction do
                @customer.save
            end
            render json: @customer
        rescue => exception
            render json: exception
        end
    end

    def update 
        begin
            @customer.update(customer_params)
            render json: @customer
        rescue => exception
            render json: exception
        end
        
    end   

    private 
    def set_customer
        @customer = Customer.find(params[:id])
    end

    def customer_params 
        params.require(:customer).permit(:id,:customer_code,:gender,:fullname,:dateOfBirth,:current_addr,:province_code,
            :registered_date,:tel,:mobile,:email,:fb,:socials)
    end
end
