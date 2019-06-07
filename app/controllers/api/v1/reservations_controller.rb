class Api::V1::ReservationsController < Api::V1::BaseController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.listing = Listing.find(params[:listing_id])
    if @reservation.save
      checkout_checkin = MissionService.checkout_checkin(params)
      render :show
    else
      render_error
    end
  end

  def update
    checkout_checkin = MissionService.find_checkout_checkin(params)
    if @reservation.update(reservation_params)
      if checkout_checkin.nil?
        checkout_checkin = MissionService.checkout_checkin(params)
      else
        checkout_checkin.destroy
        checkout_checkin = MissionService.checkout_checkin(params)
      end
      render :show
    else
      render_error
    end
  end

  def destroy
    checkout_checkin = MissionService.find_checkout_checkin(params)
    if @reservation.destroy
      checkout_checkin.destroy
      head :no_content
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def render_error
    render json: { errors: @reservation.errors.full_messages },
      status: :unprocessable_entity
  end
end
