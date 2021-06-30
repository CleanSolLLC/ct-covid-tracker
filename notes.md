<!-- CT-COVID-TRACKER PROJECT

  API Data 

  1. COVID-19 Tests, Cases, Hospitalizations, and Deaths (Statewide)  
     https://data.ct.gov/Health-and-Human-Services/COVID-19-Tests-Cases-Hospitalizations-and-Deaths-S/rf3k-f8fg  

     api: https://data.ct.gov/resource/rf3k-f8fg.json 


        Hash Keys: 

        date 
        state
        covid_19_tests_reported
        totalcases
        confirmedcases
        probablecases
        hospitalizedcases
        totaldeaths
        confirmeddeaths
        probabledeaths


        client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"}) 

        #Getting data based on a date range:             
        
        data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date between '2020-10-28T00:00:00.000' and '2020-10-29T00:00:00.000'")

        #logic for 1 date passed in
        data = client.get("https://data.ct.gov/resource/rf3k-f8fg.json", "$where" => "date='2020-10-29T00:00:00.000'")


  2. COVID-19 PCR-Based Test Results by Date of Specimen Collection (By County) **** May consider this as an extention to project at a later date ***

      web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-PCR-Based-Test-Results-by-Date-of-Specime/qfkt-uahj

      api: https://data.ct.gov/resource/qfkt-uahj.json

        Hash Keys:

        county
        date
        number_of_indeterminates
        number_of_negatives
        number_of_positives
        number_of_tests 

        client = SODA::Client.new({:domain => "https://data.ct.gov/resource/rf3k-f8fg.json"}) 

        #Getting data based on a date range:             
        
        data = client.get("https://data.ct.gov/resource/qfkt-uahj.json.json", "$where" => "date between '2020-10-28T00:00:00.000' and '2020-10-29T00:00:00.000'")

        #logic for 1 date passed in
        data = client.get("https://data.ct.gov/resource/qfkt-uahj.json", "$where" => "date='2020-10-29T00:00:00.000'")      


  3. COVID-19 Cases, Hospitalizations, and Deaths (By County)

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-Hospitalizations-and-Deaths-By-Coun/bfnu-rgqt

     api: https://data.ct.gov/resource/bfnu-rgqt.json  

      Hash Keys:

        dateupdated
        county
        confirmedcases
        hospitalization
        confirmeddeaths       


  4. COVID-19 Tests, Cases, and Deaths (By Town)
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Tests-Cases-and-Deaths-By-Town-/28fr-iqnx

     api: https://data.ct.gov/resource/28fr-iqnx.json

      Hash Keys:

        lastupdatedate
        town_no
        town
        numberoftests
        townconfirmedcases
        townconfirmeddeaths     



  5. COVID-19 Cases and Deaths by Gender
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Gender/qa53-fghg

     api: https://data.ct.gov/resource/qa53-fghg.json

      Hash Keys:

        dateupdated
        gender
        confirmedcases
        confirmeddeaths


  6. COVID-19 Cases and Deaths by Age Group

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Age-Group/ypz6-8qyf

     example: data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json?dateupdated=2020-05-01T00:00:00.000")

     Hash Keys:

      dateupdated
      agegroups
      confirmedcases
      confirmeddeaths

      Data is an array of hashes returns data for each age group

       #<Hashie::Mash agegroups="0-9" dateupdated="2020-05-01T00:00:00.000" totalcaserate="56" totalcases="214" totaldeaths="1"> 



  7. COVID-19 Cases and Deaths by Race/Ethnicity

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Race-Ethnicity/7rne-efic

     api: https://data.ct.gov/resource/7rne-efic.json

     Hash Keys:

      dateupdated
      hisp_race
      total_pop
      case_tot
      deaths

  8. COVID-19 State Summary **** Data to show on the landing page
      COVID-19 state summary including the following metrics, including the change from the data reported the previous day:

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-state-summary/ncg4-6gkj

     api: https://data.ct.gov/resource/ncg4-6gkj.json

     Hash Keys:

      measure
      total
      changedirection
      change
      dateupdated 

  9. COVID-19 Vaccine State Summary **** Data to shown on the landing page
      COVID-19 state summary data is updated one tiome per week
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Vaccine-State-Summary/tttv-egb7

     api: https://data.ct.gov/resource/tttv-egb7.json

     Hash Keys:

      date_updated
      population
      first_dose
      first_dose_coverage
      fully_vaccinated
      fully_vaccinated_percent


Models

  User - is used by this aplication as well as the Devise gem
    
  See erd.pdf for model relationships and attributes


  Model Logic  
    #1. we need to find the prev date to grab totals that will be used to compare to values with that of the nextday
    #2. check for and validate against nonexistant data
    #3. check to see if data queried persists in DB.
    #4. The above logic applies to all of the models except comments, posts, and the loolup models 

    Data was origionally colllected and posted Sunday through Thursday. However it seems like data is now being collected and posted Monday through Friday excluding holidays. The previous days data is needed to calculate the increase or decrease from the start date and each subsequent date through the end_date utilized data from the day before. If we use a prev_date that goes back 5 days prior to the start_date we are assured that we will capture the previous date.








 -->