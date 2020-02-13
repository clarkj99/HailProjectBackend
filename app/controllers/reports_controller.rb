class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]

  # GET /reports
  def index
    start_date = (params[:year] || "2020").to_i
    end_date = start_date + 1

    @reports = Report.where("time > ? AND time < ?", DateTime.new(start_date), DateTime.new(end_date)).order(time: :desc)

    render json: { count: @reports.count, reports: @reports }
  end

  # GET /reports/1
  def show
    render json: @report
  end

  #GET /dates
  def dates
    dates = Report.order(time: :desc).pluck(:time)
    dates_only = dates.map do |date|
      date.to_date
    end
    render json: dates_only.uniq
  end

  # POST /reports
  def create
    @report = Report.new(report_params)

    if @report.save
      render json: @report, status: :created, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def report_params
    params.require(:report).permit(:time, :size, :location, :city, :county, :state, :lat, :lon, :comments, :filename)
  end
end
