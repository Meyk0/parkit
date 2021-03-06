class ReservationsController < ApplicationController
  def new
    profile = Profile.find(current_user.profile.id)
    @profile = profile
    current_user.avatar = @profile.avatar
  end

  def create
    days = (session[:end].to_date - session[:start].to_date).to_i
    space = Space.find(params[:space_id])
    cost = space.price * days

    reservation = Reservation.new(start: session[:start], end: session[:end], space: space, user: current_user, total_cost: cost)
    reservation.save

    if (current_user.profile.nil?)
      redirect_to new_profile_path
    else
    redirect_to profile_path(current_user.profile.id)
    end
  end

  def destroy
    Reservation.destroy(params[:id])
    redirect_to profile_path
  end
end
