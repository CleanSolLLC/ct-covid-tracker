class County < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  #belongs_to_active_hash :town_lookup
  belongs_to :user
  has_many :towns

    #1. we need to find the prev date to grab totals that will be used to compare to current date
  #2. check to see if date falls on a Sunday
  #3. if it does we need the data from the Thursday prior to comapre with Sunday's data

  # **** CHECK TO SEE IF DATA QUERIED IS PERSISTED IN DB. IF SO THERE IS NO NEED CALL API ******

  # **** STATE_DATA SHLOULD ONLY BE CALLED IF DATA DOES NOT EXIST IN THE DB ******

  # **** THIS LOGIXC WILL ALSO APPLY TO THE OTHER MODELS COUNTY, TOWN, GENDER_CASE, ETHNIC_CASEE, AGE_GROUP ******



  def self.county_data(params, user)

    #need to retrieve date 1 day prior in order to calculate changes in data from the previous day. Data is only available Sundays through Thursdays. Need a start date and a previous date 

      if Date.parse(params[:start_date]).sunday?
        prev_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        prev_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]
      date = params[:start_date]



      #array formatting to pass values from params multi-select menu

      array = params[:county_lookup_id].values.first.reject{|t| t == ""}

      array_to_s = array.map { |s| "'#{s}'" }.join(', ')      
 

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/bfnu-rgqt.json"})
    
    
      data = client.get("https://data.ct.gov/resource/bfnu-rgqt.json", "$where" => "dateupdated between'#{prev_date}' and '#{end_date}' and cnty_cod in (#{array_to_s})")
     
  

      #We have the data that includes previous date the hash will have multiple previous dates based on the number of counties selected we need to break on change in county. prev_date should only be used for the first iteration of data to calclate an increase of decreae in data from the previous day

      #1. Iterate over the hash which is an array of hashes we want data_selected where dateupdated == params[:start_date]
      #That should return all elements in array


      sorted_data = data.body.sort_by{|hsh| hsh[:cnty_cod]}


      sorted_data.each_index do |i|

        return if sorted_data[i+1].nil?

        county_code = sorted_data[i].cnty_cod if county_code != sorted_data[i].cnty_cod

        county = County.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, cnty_cod: "#{county_code}".to_i)

          if county.id.nil? && county_code == sorted_data[i+1].cnty_cod

            county.query_date = sorted_data[i+1].dateupdated 
            county.cnty_cod = sorted_data[i+1].cnty_cod.to_i
            county.name = sorted_data[i+1].county
            county.confirmed_cases = sorted_data[i+1].confirmedcases.to_i
            county.hospitalizations = sorted_data[i+1].hospitalization.to_i
            county.confirmed_deaths = sorted_data[i+1].confirmeddeaths.to_i 

            county_code == sorted_data[i+1].cnty_cod 
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

