# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  # GET /orders/1
  # GET /orders/1.xml
  def show
    #@order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => "opa" }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_url, :notice => "Корзина пуста"
      return
    end
    @order = Order.new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @order }
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    @order.save_referer(session[:referer])

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        session[:referer] = nil
        Notifier.order_received(@order).deliver


        #if @order.line_items.find_all { |line_item| line_item.product.category.dealers_only == true }.size != 0
        #  Notifier.order_dealer_send(@order).deliver
        #else
        #  Notifier.order_send(@order).deliver
        #end

        Notifier.order_send(@order).deliver

        format.html { redirect_to('/content/happy', :notice => 'Пасибки за заказ') }
        format.xml { render :xml => @order, :status => :created,
                            :location => @order }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @order.errors,
                            :status => :unprocessable_entity }
      end
    end
  end
end
