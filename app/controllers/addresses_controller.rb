class AddressesController < ApplicationController
  before_action :move_to_signup
  before_action :set_params
  before_action :move_to_top

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_number).merge(user_id: params[:user_id])
  end

  def move_to_signup
    redirect_to new_user_session_path unless user_signed_in?
  end
  
  def set_params
    @user = User.find(params[:user_id])
    @address = Address.find(params[:id])
  end

  def move_to_top
    redirect_to root_path if @user.id != @address.user_id
  end

end
