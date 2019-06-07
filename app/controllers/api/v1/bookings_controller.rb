class Api::V1::BookingsController < Api::V1::BaseController
  before_action :set_booking, only: [:show, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.listing = Listing.find(params[:listing_id])
    if @booking.save
      first_checkin = MissionService.first_checkin(params)
      checkout = MissionService.last_checkout(params)
      render :show
    else
      render_error
    end
  end

  def update
    checkin_mission = MissionService.find_first_checkin(params)
    checkout_mission = MissionService.find_last_checkout(params)
    if @booking.update(booking_params)
      checkin_mission.update(date: params[:start_date])
      checkout_mission.update(date: params[:end_date])
      render :show
    else
      render_error
    end
  end

  def destroy
    checkin_mission = MissionService.find_first_checkin(params)
    checkout_mission = MissionService.find_last_checkout(params)
    if @booking.destroy
      checkin_mission.destroy
      checkout_mission.destroy
      head :no_content
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def render_error
    render json: { errors: @booking.errors.full_messages },
      status: :unprocessable_entity
  end
end
