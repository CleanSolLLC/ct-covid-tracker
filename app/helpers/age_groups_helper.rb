module AgeGroupsHelper
  def age_group_error?
    
    if params[:age_group_lookup_id].values[0].last.empty?
      flash[:alert] = "You must select at least 1 age group" 
    end

    true if !flash[:alert].nil? 

  end   
end
