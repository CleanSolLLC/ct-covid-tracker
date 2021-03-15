class County < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :town_lookup
  belongs_to :user
  has_many :towns



  def self.county_data(params, user)

      if Date.parse(params[:start_date]).sunday?
        start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        start_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]
 

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/bfnu-rgqt.json"})

      array = params[:county_lookup_id].values.first.reject{|t| t == ""}

      array_to_s = array.map { |s| "'#{s}'" }.join(', ')
    
      data = client.get("https://data.ct.gov/resource/bfnu-rgqt.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}' and cnty_cod in (#{array_to_s})")
     

  
      #   county = County.find_or_initialize_by(user_id: user.id, query_date: date)

      #   if county.id.nil? && (!Date.parse(date).friday? || !Date.parse(date).saturday?)

      #     county.query_date = data.body[i].date 
      #     county.total_tests = data.body[i].covid_19_tests_reported.to_i
      #     county.total_cases = data.body[i].totalcases.to_i
      #     county.confirmed_cases = data.body[i].confirmedcases.to_i
      #     county.hospitalized_cases = data.body[i].hospitalizedcases.to_i
      #     county.confirmed_deaths = data.body[i].confirmeddeaths.to_i
      #     county.test_change = (data.body[i].covid_19_tests_reported.to_i - data.body[i-1].covid_19_tests_reported.to_i)
      #     (data.body[i-1].covid_19_tests_reported.to_i < data.body[i].covid_19_tests_reported.to_i) ? county.test_dir = "+" : county.test_dir = "-"
      #     county.case_change = (data.body[i].totalcases.to_i - data.body[i-1].totalcases.to_i)
      #     (data.body[i-1].totalcases.to_i < data.body[i].totalcases.to_i) ? county.case_dir = "+" : county.case_dir = "-"
      #     county.hospitalized_change = (data.body[i].hospitalizedcases.to_i - data.body[i-1].hospitalizedcases.to_i)
      #     (data.body[i-1].hospitalizedcases.to_i < data.body[i].hospitalizedcases.to_i) ? county.hosp_dir = "+" : county.hosp_dir = "-"
      #     county.death_change = (data.body[i].confirmeddeaths.to_i - data.body[i-1].confirmeddeaths.to_i)
      #     (data.body[i-1].confirmeddeaths.to_i < data.body[i].confirmeddeaths.to_i) ? county.death_dir = "+" : county.death_dir = "-"

      #     user.counties << county
      #   end
       
      #   date = (Date.parse(date) + 1).to_s   
      #   i+=1
      # end
  end
end

