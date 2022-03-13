class Admin::ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to admin_listing_path(@listing)
    else
      flash[:errors] = @listing.errors.full_messages
      redirect_to new_admin_listing_path
    end
  end

  def edit
    @listing = Listing.find(params[:id])

    redirect_to edit_admin_listing_path
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(listing_params)
      redirect_to admin_listing_path(@listing)
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :edit
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.update!(status: :archived)

    redirect_to admin_listings_path
  end

  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :max_guests)
  end
end
