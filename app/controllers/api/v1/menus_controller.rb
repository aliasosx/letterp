class Api::V1::MenusController < ApplicationController
    def index        
        render json: Menu.where(enabled:true).order(menu_order: :asc)
    end
    
    def show     
        mnu = Menu.where(enabled:true).order(menu_order: :asc)   
        user  = UserMaster.find_by(user_id: menu_params[:id])        
        tranx_role  = TranxRole.find_by(user_id: user.user_id)
        tranx_menu = TranxMenu.where(role_id:tranx_role.role_id )
        
        profile = { user: user, role: tranx_role , menues: tranx_menu }        
        render json: profile
    end

    private
    def menu_params
        params.permit(:id)
    end
end
