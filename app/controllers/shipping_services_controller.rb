class ShippingServicesController < ApplicationController

  def search
    # All the shipping options for a given package/origin/destination, by calling the ShippingOption model search method.
    # options = ShippingOption.search(params[:query])
      # origin, destination, package
    options = ShippingOption.search(params[:origin], params[:destination], params[:package])
    render json: options
  end

  def show
    option = ShippingOption.find_by(id: params[:id])
    unless option.nil?
      # The details of a specific shipping option.
      render json: option
    else
      render nothing: true, status: :not_found
    end
  end
end
