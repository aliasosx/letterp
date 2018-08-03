class Api::V1::SaleController < ApplicationController
    def index
        render json: Sale.all()
    end   

    def create
        begin
            # Create new Sale
            s = Sale.new
            s.product_code = sale_params[:product_code] 
            s.quantity = sale_params[:quantity]
            s.price = sale_params[:price]
            s.total = s.quantity.to_i * s.price.to_i
            s.discount = sale_params[:discount]
            s.discount_amount = (s.total * s.discount.to_i)/100
            s.total_price = s.total - s.discount_amount
            
            s.currency_code = sale_params[:currency_code]
            s.sale_date = sale_params[:sale_date]
            s.terminal_code = sale_params[:terminal_code]
            s.customer_code = sale_params[:customer_code]
            
            #Get Current Stock
            stock = Stock.find_by(product_code: sale_params[:product_code])
            current_stock_before = stock.current_stock
            puts 'Current stock ' + stock.current_stock.to_s + ' Unit(s)'
            #Check Stock Availability
            if stock.current_stock >= sale_params[:quantity].to_i
                puts '============== Stock OK =============='
                st = Stock.find(stock.id)
                st.current_stock = (stock.current_stock - sale_params[:quantity].to_i)
                puts '============== New Current stock is ' + st.current_stock.to_s + ' Unit(s) =============='
                #Update stock tracking
                stock_trc = StockTracking.new
                stock_trc.product_code = sale_params[:product_code] 
                stock_trc.old_quantity = current_stock_before.to_i
                stock_trc.current_quantity = st.current_stock
                puts '============== Stock tracking =============='
                puts 'Current ' + stock_trc.current_quantity.to_s + ' Unit(s)'
                ctn = CustomerPoint.new()    
                @customer_point  = CustomerPoint.new()         
                @customer_point_history = CustomerPointHistory.new()
                #Point Promotion Checking 
                
                if ProductPoint.exists?(:product_code => sale_params[:product_code]) 
                    puts '============== Promotion calculation start =============='
                    point = ProductPoint.find_by(product_code:sale_params[:product_code])
                    if s.quantity.to_i >= point.quantity.to_i 
                        puts '============== Meet the promotion condition =============='
                        #Check New Customer Or Old 
                        if CustomerPoint.exists?(:customer_code => sale_params[:customer_code])
                             puts '============== Old Customer =============='
                             @customer_point = CustomerPoint.find_by(customer_code: sale_params[:customer_code])
                             @customer_point.point = ((s.quantity.to_i * point.point.to_i)/point.quantity) +  @customer_point.point
                             @customer_point_history.customer_code = sale_params[:customer_code]
                             @customer_point_history.point = @customer_point.point
                        else                            
                            puts '============== new Customer =============='                            
                            ctn.customer_code = sale_params[:customer_code]
                            ctn.point = (s.quantity.to_i * point.point.to_i)/point.quantity       
                            @customer_point_history.customer_code = sale_params[:customer_code]
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
                    
                    puts '============== New sale for ' + sale_params[:product_code]
                    s.tranxlogid = SecureRandom.uuid
                    s.save
                    puts '============== Stock udpate for ' + sale_params[:product_code]
                    st.update(id:stock.id)
                    puts '============== Add Stock tracking ' + sale_params[:product_code]
                    stock_trc.transxlogid = s.tranxlogid
                    stock_trc.save     
                    if ctn.customer_code?
                        puts '============== Save point New User ' + sale_params[:product_code]   
                        @customer_point_history.tranxlogid = s.tranxlogid
                        ctn.save
                        @customer_point_history.save
                    end                                
                    if @customer_point.customer_code?
                        puts '============== Save point Old User' + sale_params[:product_code]
                        @customer_point_history.tranxlogid = s.tranxlogid
                        @customer_point.save
                        @customer_point_history.save
                    end
                end
                render json: { status: 'Sale Completed' }
            else
                puts '============== Stock less than sale request =============='
                render json: { status: 'Out of Stock for this Goods or Services' }
            end            
        rescue => exception
            render json: { status: exception }
        end 
    end
    
    private 
    def sale_params
        params.permit(:id,:product_code,:quantity,:price,:currency_code,:sale_date,:terminal_code,:discount,:customer_code)
    end
end
