# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
	def hour_minute(date)
		date.strftime("%H:%M")
	end
	
	def year_month_day(date)
		date.strftime("%y.%m.%d")
	end
	
end
