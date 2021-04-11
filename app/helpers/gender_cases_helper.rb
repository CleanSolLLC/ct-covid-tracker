module GenderCasesHelper
	
  def check_date

    if !params[:start_date].present? || !params[:end_date].present?
      flash[:alert] = "Start Date or End Date Cannot Be Blank"
      redirect_to new_user_gender_case_path(current_user)

    
    elsif Date.parse(params[:start_date]).friday? || Date.parse(params[:start_date]).saturday?
      flash[:alert] = "Start Date Cannot Be on a Friday or Saturday"
      redirect_to new_user_gender_case_path(current_user)
      

    elsif Date.parse(params[:start_date]) >= Date.today || Date.parse(params[:end_date]) >= Date.today
      flash[:alert] = "Start or End Date Cannot Be Today or In The Future"
      redirect_to new_user_gender_case_path(current_user)

    elsif Date.parse(params[:start_date]) > Date.parse(params[:end_date])
      flash[:alert] = "Start Date Cannot Be Greater Than End Date"
      redirect_to new_user_gender_case_path(current_user)      

    end

  end	

end
