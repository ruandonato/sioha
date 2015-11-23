class CalendarController < ApplicationController
# this method allows the calendar to show the date updated
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
