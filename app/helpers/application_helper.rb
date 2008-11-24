module ApplicationHelper
  
  def hour_minute(date)
    date.strftime("%d.%m.%y - %H:%M")
  end
  
  def year_month_day(date)
    date.strftime("%d.%m.%Y")
  end
  
  def current(lang)
    {:controller=>controller.controller_name, :action => controller.action_name, :locale =>lang, :id=>params[:id], :league_id=>params[:league_id]}
  end
  
#  def leagues?
#    return true if %w{teams leagues matches rounds}.include?(controller.controller_name)
#  end

	def flash_messages
	  messages = []
    %w(notice error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :id => "#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
	end
end
