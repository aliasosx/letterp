class Api::V1::AuthenticatesController < ApplicationController
    def login        
            user = UserMaster.find_by_email(userparams[:email])
            if user && user.authenticate(userparams[:password])
                render json: user
            else
                render json: {status: 'Fail'}
            end        
    end

    private 
    def userparams
        params.permit(:email,:password)
    end

end
