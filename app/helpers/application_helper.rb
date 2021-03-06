module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(date)
    if logged_in? and !current_user.time_zone.blank?
      date = date.in_time_zone(current_user.time_zone)
    end
    date.strftime("%m/%d/%y %l:%M%P %Z")
  end

  def ajax_flash(div_id)
    response = ""
    flash_div = ""

    flash.each do |name, msg|
      if msg.is_a?(String)
        flash_div = "<div class=\"alert alert-#{name == :notice ? 'success' : 'error'} ajax_flash\"><a class=\"close\" data-dismiss=\"alert\">&#215;</a> <div id=\"flash_#{name == :notice ? 'notice' : 'error'}\">#{h(msg)}</div> </div>"
      end 
    end
    
    response = "$('.ajax_flash').remove();$('#{div_id}').prepend('#{flash_div}');"
    response.html_safe
  end
end
