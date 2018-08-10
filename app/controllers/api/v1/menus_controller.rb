class Api::V1::MenusController < ApplicationController
    def index
        #@menus = Menu.find_by(enabled: true)
        #render json: @menus
        render json: Menu.where(enabled:true).order(menu_order: :asc)
    end

end
