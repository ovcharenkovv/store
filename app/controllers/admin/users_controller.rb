# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @posts }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(admin_users_path, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      flash[:notice] = 'User was successfully deleted.'
      format.html { redirect_to(admin_users_url) }
      format.xml { head :ok }
    end
  end

end
