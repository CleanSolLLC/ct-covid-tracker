module CountiesHelper

  def county_error?
    
    if params[:county_lookup_id].values[0].last.empty?
      flash[:alert] = "You must select at least 1 county"
    end
    
    true if !flash[:alert].nil?
    
  end

end
