# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def hour_minute(date)
    date.strftime("%H:%M")
  end
  
  def year_month_day(date)
    date.strftime("%y.%m.%d")
  end
  
  def leagues?
    flag = false
    %w{teams leagues matches rounds}.each do |check|
      flag = true if check.eql?(controller.controller_name)
    end
    flag
  end
end
