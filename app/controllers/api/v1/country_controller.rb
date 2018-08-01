class Api::V1::CountryController < ApplicationController
    def index()
        render json: Country.all()
    end
    def show()
        @countries = Country.find(country_param[:id])
        render json: @countries
    end
    private 
    def country_param()
        params.permit(:id, :country_code, :country_name)
    end
end
