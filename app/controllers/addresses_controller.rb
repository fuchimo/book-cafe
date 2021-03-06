class AddressesController < ApplicationController

  def edit
    @address = Address.find(current_user.id)
  end

  def update
    @address = Address.find(current_user.id)
    if@address.update(address_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_number).merge(user_id: current_user.id)
  end

end
