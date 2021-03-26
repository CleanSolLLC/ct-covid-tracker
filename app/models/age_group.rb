class AgeGroup < ApplicationRecord
  belongs_to :user

  	def self.age_data(params, user)
  
      if Date.parse(params[:start_date]).sunday?
        start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        start_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]


  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ypz6-8qyf.json"})

      data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")

      
      sorted_data = data.body.sort_by{|hsh| hsh[:agegroups]}

      binding.pry
      #while i < sorted_data.count

      sorted_data.each_index do |i|

        return if sorted_data[i+1].nil?

        age_range = sorted_data[i].agegroups if age_range != sorted_data[i].agegroups

        age_group = AgeGroup.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, age_group: "#{age_group}")

          if age_group.id.nil? && age_range == sorted_data[i+1].agegroups

            age_group.query_date = sorted_data[i+1].dateupdated
            age_group.age_group = sorted_data[i+1].agegroups
            age_group.confirmed_cases = sorted_data[i+1].confirmedcases.to_i
            age_group.confirmed_deaths = sorted_data[i+1].confirmeddeaths.to_i 

            age_group == sorted_data[i+1].agegroups
            age_group.case_change = (sorted_data[i+1].confirmedcases.to_i - sorted_data[i].confirmedcases.to_i) 
            (sorted_data[i+1].confirmedcases.to_i > sorted_data[i].confirmedcases.to_i) ? age_group.case_dir = "+" : age_group.case_dir = "-"
            age_group.death_change = (sorted_data[i+1].confirmeddeaths.to_i - sorted_data[i].confirmeddeaths.to_i)
            (sorted_data[i+1].confirmeddeaths.to_i > sorted_data[i].confirmeddeaths.to_i) ? age_group.death_dir = "+" : age_group.death_dir = "-"
          
            user.age_groups << age_group

          end

        end


      # binding.pry
      # days = 0
      # i = 0      
      # date = params[:start_date]

      # while days <= (Date.parse(params[:end_date]) - Date.parse(params[:start_date])).to_i  
        
      #   age_group = AgeGroup.find_or_initialize_by(user_id: user.id, query_date: data.body[i].dateupdated, age_group: data.body[i].agegroups) 
       
      #   if age_group.id.nil? && !data.body[i].nil?
      #     age_group.query_date = data.body[i].dateupdated
      #     age_group.age_group = data.body[i].agegroups
      #     age_group.confirmed_cases = data.body[i].confirmedcases
      #     age_group.confirmed_deaths = data.body[i].confirmeddeaths
      #     user.age_groups << age_group
      #   end
       
      #   date = (Date.parse(date) + 1).to_s
      #   days+=1
      #   i+=1
      # end
    end

end

