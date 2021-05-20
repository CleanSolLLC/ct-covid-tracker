module TownsHelper

  def town_error?
    
    if params[:town_lookup_id].values[0].last.empty?
      flash[:alert] = "You must select at least 1 town"
    end

    true if !flash[:alert].nil?

  end

end
