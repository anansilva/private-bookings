class Admin::PhotosController < ApplicationController
  def index
    @listing = current_user.listings.find(params[:listing_id])
    @photos = @listing.photos
  end

  def create
    @listing = current_user.listings.find(params[:listing_id])
    @photo = @listing.photos.create!
    if @photo.save
      redirect_to admin_listing_path(@listing)
    else
      flas[:errors] = @photo.errors.full_messages
    end
  end
end
