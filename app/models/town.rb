class Town < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :county
  belongs_to_active_hash :county_lookup, :shortcuts => [:name]


  #1. we need to find the prev date to grab totals that will be used to compare to current date
  #2. check to see if date falls on a Sunday
  #3. if it does we need the data from the Thursday prior to comapre with Sunday's data

  # **** CHECK TO SEE IF DATA QUERIED IS PERSISTED IN DB. IF SO THERE IS NO NEED CALL API ******

  # **** STATE_DATA SHLOULD ONLY BE CALLED IF DATA DOES NOT EXIST IN THE DB ******

  # **** THIS LOGIXC WILL ALSO APPLY TO THE OTHER MODELS COUNTY, TOWN, GENDER_CASE, ETHNIC_CASEE, AGE_GROUP ******



  def self.town_data(params, user)

    #need to retrieve date 1 day prior in order to calculate changes in data from the previous day. Data is only available Sundays through Thursdays. Need a start date and a previous date 

      if Date.parse(params[:start_date]).sunday?
        prev_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        prev_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]
      date = params[:start_date]



      #array formatting to pass values from params multi-select menu

      array = params[:town_lookup_id].values.first.reject{|t| t == ""}

      array_to_s = array.map { |s| "'#{s}'" }.join(', ')      
 

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/28fr-iqnx.json"})

  	  binding.pry

    
      data = client.get("https://data.ct.gov/resource/28fr-iqnx.json", "$where" => "lastupdatedate between'#{prev_date}' and '#{end_date}' and town_no in (#{array_to_s})")
     
  

      #We have the data that includes previous date the hash will have multiple previous dates based on the number of counties selected we need to break on change in county. prev_date should only be used for the first iteration of data to calclate an increase of decreae in data from the previous day

      #How do we do this?????

      #1. Iterate over the hash which is an array of hashes we want data_selected where dateupdated == params[:start_date]
      #That should return all elements in array


      sorted_data = data.body.sort_by{|hsh| hsh[:town_no]}


      #while i < sorted_data.count

      sorted_data.each_index do |i|
      	binding.pry

        return if sorted_data[i+1].nil?

        town_code = sorted_data[i].town_no if town_code != sorted_data[i].town_no

        town = Town.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].lastupdatedate}".to_date, town_cod: "#{town_code}".to_i)

          if town.id.nil? && town_code == sorted_data[i+1].town_no

            town.query_date = sorted_data[i+1].lastupdatedate 
            town.town_cod = sorted_data[i+1].town_no.to_i
            town.name = sorted_data[i+1].town
            town.total_tests = sorted_data[i+1].numberoftests.to_i
            town.confirmed_cases = sorted_data[i+1].townconfirmedcases.to_i
            town.confirmed_deaths = sorted_data[i+1].townconfirmeddeaths.to_i 

            town_code == sorted_data[i+1].town_no
            town.test_change = (sorted_data[i+1].numberoftests.to_i - sorted_data[i].numberoftests.to_i)
            (sorted_data[i+1].numberoftests.to_i > sorted_data[i].numberoftests.to_i) ? town.test_dir = "+" : town.test_dir = "-"
            town.case_change = (sorted_data[i+1].townconfirmedcases.to_i - sorted_data[i].townconfirmedcases.to_i) 
            (sorted_data[i+1].townconfirmedcases.to_i > sorted_data[i].townconfirmedcases.to_i) ? town.case_dir = "+" : town.case_dir = "-"
            town.death_change = (sorted_data[i+1].townconfirmeddeaths.to_i - sorted_data[i].townconfirmeddeaths.to_i)
            (sorted_data[i+1].townconfirmeddeaths.to_i > sorted_data[i].townconfirmeddeaths.to_i) ? town.death_dir = "+" : town.death_dir = "-"
          

            user.towns << town

          end

        end

  end
end

