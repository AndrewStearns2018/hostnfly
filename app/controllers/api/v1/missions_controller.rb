class Api::V1::MissionsController < Api::V1::BaseController
  def index
    @missions = Mission.all
  end
end
