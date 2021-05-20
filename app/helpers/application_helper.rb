module ApplicationHelper

  def date_error?

    if !params[:start_date].present? || !params[:end_date].present?
      flash[:alert] = "Start Date or End Date Cannot Be Blank"
    
    elsif Date.parse(params[:start_date]).friday? || Date.parse(params[:start_date]).saturday?
      flash[:alert] = "Start Date Cannot Be on a Friday or Saturday"
    
    elsif Date.parse(params[:start_date]) >= Date.today || Date.parse(params[:end_date]) >= Date.today
      flash[:alert] = "Start or End Date Cannot Be Today or In The Future"

    elsif Date.parse(params[:start_date]) > Date.parse(params[:end_date])
      flash[:alert] = "Start Date Cannot Be Greater Than End Date"     
    end
    
    true if !flash[:alert].nil?

  end
  
end
