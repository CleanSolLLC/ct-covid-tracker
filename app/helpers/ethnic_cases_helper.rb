module EthnicCasesHelper

  def ethnic_case_error?
    
    if params[:ethnic_case_lookup_id].values[0].last.empty?
      flash[:alert] = "You must select at least 1 ethnic group"
      redirect_to new_user_ethnic_case_path(current_user) 
    end

    true if !flash[:alert].nil?
    
  end	
end
