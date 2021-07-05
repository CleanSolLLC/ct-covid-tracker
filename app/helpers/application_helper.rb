module ApplicationHelper

  #date_error will avoid passing invalid dates to the api. Note that each api endpoint may have a differnt begin date for collecting data

  def date_error?

    dates = {
      "age_groups" => Date.parse("2020-04-06"),
      "counties" => Date.parse("2020-03-25"),
      "ethnic_cases" => Date.parse("2020-04-21"),
      "gender_cases" => Date.parse("2020-04-06"),
      "states" => Date.parse("2020-03-25"),
      "towns" => Date.parse("2020-03-25")
    }

    if !params[:start_date].present? || !params[:end_date].present?
      flash[:alert] = "Start Date or End Date Cannot Be Blank"
    
    elsif Date.parse(params[:start_date]) <  dates[controller_name] || Date.parse(params[:end_date]) < dates[controller_name] 
      flash[:alert] = "Start Date or End Date Cannot Be Before #{dates[controller_name].strftime("%m/%d/%Y")}"
    
    elsif Date.parse(params[:start_date]) >= Date.today || Date.parse(params[:end_date]) >= Date.today
      flash[:alert] = "Start or End Date Cannot Be Today or In The Future"

    elsif Date.parse(params[:start_date]) > Date.parse(params[:end_date])
      flash[:alert] = "Start Date Cannot Be Greater Than End Date"     
    end
    
    true if !flash[:alert].nil?

  end
  
end
