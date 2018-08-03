class Api::V1::TerminalsController < ApplicationController
    def index 
        render json: Terminal.all()
    end
    def create
        begin
            t = Terminal.new
            t.terminal_serials = terminals_params[:terminal_serials]
            t.terminal_name = terminals_params[:terminal_name]
            t.floor_id = terminals_params[:floor_id]
            t.enabled = terminals_params[:enabled]
            Terminal.transaction do 
                t.save!
            end
            render json: { status: 'Terminal '+ t.terminal_name + ' Has been saved'}
        rescue => exception
            render json: { status: exception}
        end        
    end

    def destroy
        begin
            terminal_name = Terminal.find(terminals_params[:id]).terminal_name
            Terminal.destroy(terminals_params[:id])
            render json: { status: 'Terminal ' + terminal_name + 'has been destroyed'}
        rescue => exception
            render json: { status: exception }
        end
    end

    private
    def terminals_params
        params.permit(:id,:terminal_serials,:terminal_name,:floor_id,:enabled)
    end
end
