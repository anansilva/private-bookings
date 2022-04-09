class Admin::RoomsController < ApplicationController
  def index
    @listing = Listing.find(params[:listing_id])
    @rooms = @listing.rooms
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @room = @listing.rooms.new(room_params)

    if @room.save
      redirect_to admin_listing_rooms_path(@listing)
    else
      flash[:errors] = @room.errors.full_messages
    end
  end

  def destroy
    @listing = Listing.find(params[:listing_id])
    @room = @listing.rooms.find(params[:id])
    @room.destroy
    redirect_to admin_listing_rooms_path(@listing)
  end

  private

  def room_params
    params.require(:room).permit(:room_type, beds_attributes: [:bed_size, :_destroy])
  end
end
