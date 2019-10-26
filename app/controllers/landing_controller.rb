class LandingController < ApplicationController
  before_action :set_default_date_filter

  def index
    @stats = ServiceStatsSerializer::MedicalService.new(
      starts_from: params[:starts_from],
      ends_to: params[:ends_to]
    ).serializable_hash
  end

  private

  def set_default_date_filter
    params[:starts_from] ||= Time.now.beginning_of_week
    params[:ends_to] ||= Time.now.end_of_week
  end
end
