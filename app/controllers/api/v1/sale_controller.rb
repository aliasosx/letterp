class Api::V1::SaleController < ApplicationController
    before_action :set_sale, only: [:show, :edit, :update, :destroy]
    def index
        @sale = Sale.all()
        render json: @sale
    end   

    def create
        begin
            #Create 
        @sale = Sale.new(sale_params)
        @sale.total = (@sale.quantity.to_i * @sale.price.to_i)
        @sale.discount_amount = (@sale.total.to_i * @sale.discount)/100
        @sale.total_price = @sale.total - @sale.discount_amount
        #@sale.transxlogid = SecureRandom.uuid

        #Get Current Stock
        @stock = Stock.find_by(product_code: @sale.product_code)
        current_stock_before = @stock.current_stock
        puts 'Current stock ' + @stock.current_stock.to_s + ' Unit(s)'
        #Check Stock Availability
        if @stock.current_stock >= @sale.quantity.to_i
            puts '============== Stock OK =============='
            @st = Stock.find(@stock.id)
            @st.current_stock = (@stock.current_stock.to_i - @sale.quantity.to_i)
            puts '============== New Current stock is ' + @st.current_stock.to_s + ' Unit(s) =============='
            #Update stock tracking
            current_stock_before = @stock.current_stock
            @stock_trc = StockTracking.new
            @stock_trc.product_code = @sale.product_code 
            @stock_trc.old_quantity = current_stock_before.to_i
            @stock_trc.current_quantity = @st.current_stock
            @stock_trc.description = 'api'
            puts '============== Stock tracking =============='
            puts 'Current ' + @stock_trc.current_quantity.to_s + ' Unit(s)'

            #Customer Point Check
            @ctn = CustomerPoint.new()    
                @customer_point  = CustomerPoint.new()         
                @customer_point_history = CustomerPointHistory.new()
                #Point Promotion Checking 
                
                if ProductPoint.exists?(:product_code => @sale.product_code ) 
                    puts '============== Promotion calculation start =============='
                    point = ProductPoint.find_by(product_code:@sale.product_code)
                    if @sale.quantity.to_i >= point.quantity.to_i 
                        puts '============== Meet the promotion condition =============='
                        #Check New Customer Or Old 
                        if CustomerPoint.exists?(:customer_code => @sale.customer_code )
                             puts '============== Old Customer =============='
                             @customer_point = CustomerPoint.find_by(customer_code:  @sale.customer_code)
                             @customer_point.point = ((@sale.quantity.to_i * point.point.to_i)/point.quantity) +  @customer_point.point
                             @customer_point_history.customer_code =  @sale.customer_code
                             @customer_point_history.point = @customer_point.point
                        else                            
                            puts '============== new Customer =============='                            
                            ctn.customer_code =  @sale.customer_code
                            ctn.point = (@sale.quantity.to_i * point.point.to_i)/point.quantity       
                            @customer_point_history.customer_code =  @sale.customer_code
                            @customer_point_history.point = @customer_point.point                     
                            puts '============== Your point is : ' + ctn.point.to_s + ' Point(s)' 
                        end                        
                    else 
                        puts '============== Need to by ' + point.quantity.to_s  + ' to get ' + point.point.to_s + ' Point(s) =============='
                    end
                else 
                    puts '============== no Promotion now =============='
                end 
                
                #Transaction start 
                ActiveRecord::Base.transaction do 
                    puts '============== New sale for ' + @sale.product_code
                    @sale.tranxlogid = SecureRandom.uuid
                    @sale.save
                    puts '============== Stock udpate for ' + @sale.product_code
                    @st.update(id:@stock.id)
                    puts '============== Add Stock tracking ' + @sale.product_code
                    @stock_trc.transxlogid = @sale.tranxlogid
                    @stock_trc.save     
                    if @ctn.customer_code?
                        puts '============== Save point New User ' + @sale.customer_code   
                        @customer_point_history.tranxlogid = @sale.tranxlogid
                        @ctn.save
                        @customer_point_history.save
                    end                                
                    if @customer_point.customer_code?
                        puts '============== Save point Old User' + @sale.customer_code
                        @customer_point_history.tranxlogid = @sale.tranxlogid
                        @customer_point.save
                        @customer_point_history.save
                    end
                end

        else 
            puts '============== Stock less than sale request =============='
            render json: { status: 'Out of Stock for this Goods or Services' }
        end        
        render json: { status: @sale }
        rescue => exception
            render json: exception
        end
        
    end
    
    private 
    def set_sale
        @sale = Sale.find(params[:id])
    end
    def sale_params
        params.require(:sale).permit(:id,:product_code,:quantity,:price,:currency_code,:sale_date,:terminal_code,:discount,:customer_code)
    end
end
