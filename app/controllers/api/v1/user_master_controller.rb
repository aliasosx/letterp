class Api::V1::UserMasterController < ApplicationController
    def create 
        user = UserMaster.new(user_params)
        begin
            if user.save
                render json: { status: 'success' }
            else
                render json: { status: 'failed' }
            end
        rescue => exception
            render json: { status: 'failed' }
        end        
    end

    def index        
        render json: UserMaster.all()
    end   
    
    private
    def user_params
        params.permit(:user_id,:gender,:username_en,:username_la,:email,:password,:password_confirmation)
    end
end
