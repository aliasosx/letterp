class Api::V1::BannersController < ApplicationController
    before_action :set_banner, only: [:show, :edit, :update, :destroy]
    def index 
        render json: Banner.all()
    end
    def create 
        @banner = Banner.new(banner_param)
        @banner.save
        render json: @banner
    end

    def update 
        @banner = Banner.update(banner_param)
        render json: { status: @banner}
    end

    def destroy
        @banner.destroy
        render json: { status:"deleted"}
    end

    private 
    def set_banner 
        @banner = Banner.find(params[:id])
    end
    def banner_param
        params.require(:banner).permit(:id,:company_code,:company_name,:established_date)
    end
end
