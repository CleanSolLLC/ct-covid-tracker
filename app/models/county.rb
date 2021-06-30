class County < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  extend GetData

  belongs_to :user

  def self.county_data(params, user)

      prev_date = get_prev_date(params[:start_date])
      end_date = params[:end_date]

      #array formatting to pass values from params multi-select menu

      array = params[:county_lookup_id].values.first.reject{|t| t == ""}

      array_to_s = array.map { |s| "'#{s}'" }.join(', ')      
 

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/bfnu-rgqt.json"})
    
    
      data = client.get("https://data.ct.gov/resource/bfnu-rgqt.json", "$where" => "dateupdated between'#{prev_date}' and '#{end_date}' and cnty_cod in (#{array_to_s})")
     
       
      data_found = find_data(params[:start_date], data) 
      sorted_data = data_found.sort_by{|hsh| hsh[:cnty_cod]}

      
      sorted_data.each_index do |i|

        return if sorted_data[i+1].nil?

        county_code ||= sorted_data[i].cnty_cod

        county = County.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, cnty_cod: "#{county_code}".to_i)

          if county.id.nil? && county_code == sorted_data[i+1].cnty_cod

            county.query_date = sorted_data[i+1].dateupdated 
            county.cnty_cod = sorted_data[i+1].cnty_cod.to_i
            county.name = sorted_data[i+1].county
            county.confirmed_cases = sorted_data[i+1].confirmedcases.to_i
            county.hospitalizations = sorted_data[i+1].hospitalization.to_i
            county.confirmed_deaths = sorted_data[i+1].confirmeddeaths.to_i 

            county.case_change = (sorted_data[i+1].confirmedcases.to_i - sorted_data[i].confirmedcases.to_i).abs 
            (sorted_data[i+1].confirmedcases.to_i > sorted_data[i].confirmedcases.to_i) ? county.case_dir = "+" : county.case_dir = "-" unless county.case_change == 0
            county.hospitalized_change = (sorted_data[i+1].hospitalization.to_i - sorted_data[i].hospitalization.to_i).abs
            (sorted_data[i+1].hospitalization.to_i > sorted_data[i].hospitalization.to_i) ? county.hosp_dir = "+" : county.hosp_dir = "-" unless county.hospitalized_change == 0
            county.death_change = (sorted_data[i+1].confirmeddeaths.to_i - sorted_data[i].confirmeddeaths.to_i).abs
            (sorted_data[i+1].confirmeddeaths.to_i > sorted_data[i].confirmeddeaths.to_i) ? county.death_dir = "+" : county.death_dir = "-" unless county.death_change == 0
          

            user.counties << county

          end

        end

  end
end

