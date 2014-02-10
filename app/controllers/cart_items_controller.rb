class CartItemsController < ApplicationController
  before_filter :is_in_store

  # POST /cart_items
  def create
    current_cart.items.create(create_cart_item_params)
    redirect_to store_path
  end

  # PATCH /cart_items/:product_id/:product_amount
  def update
    existing_cart_item.update_attributes(update_cart_item_params)
    redirect_to store_path
  end

  # DELETE /cart/:id
  def destroy
    existing_cart_item.destroy
    redirect_to store_path
  end

  private

  def existing_cart_item
    current_cart.items.where(id: params[:id]).first
  end

  def create_cart_item_params
    params.require(:cart_item).permit(:product_id, :amount)
  end

  def update_cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end