CT-COVID-TRACKER PROJECT

Flatiron 

https://www.loom.com/share/9e066894c613463684bc094694a9fa09


Use of several state of CT apis:
      
     key id: 30szkkjvrgf2tdgoybcjrepsb
     key secret: 19a3jmgptqif5fqf9sgzo1vmg1rcjqfcs86xm0v2uo1l0f0zil

  1. COVID-19 Tests, Cases, Hospitalizations, and Deaths (Statewide) ✔ 
     https://data.ct.gov/Health-and-Human-Services/COVID-19-Tests-Cases-Hospitalizations-and-Deaths-S/rf3k-f8fg  

     api: https://data.ct.gov/resource/rf3k-f8fg.json 


        Hash Keys Used: 

        date - should we make this the primary key????
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


  2. COVID-19 PCR-Based Test Results by Date of Specimen Collection (By County)

      web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-PCR-Based-Test-Results-by-Date-of-Specime/qfkt-uahj

      api: https://data.ct.gov/resource/qfkt-uahj.json

        Hash Keys:

        county
        date - should we make this the primary key????
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


  2. COVID-19 Tests, Cases, and Deaths (By Town)
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Tests-Cases-and-Deaths-By-Town-/28fr-iqnx

     api: https://data.ct.gov/resource/28fr-iqnx.json



  3. COVID-19 Cases and Deaths by Gender
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Gender/qa53-fghg

     api: https://data.ct.gov/resource/qa53-fghg.json

      Hash Keys:

        dateupdated
        gender
        totalcases
        totaldeaths


  4. COVID-19 Cases and Deaths by Age Group

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Age-Group/ypz6-8qyf

     example: data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json?dateupdated=2020-05-01T00:00:00.000")

     Hash Keys:

      dateupdated
      agegroups
      totalcases
      totaldeaths

      Data is an array of hashes returns data for each age group

       #<Hashie::Mash agegroups="0-9" dateupdated="2020-05-01T00:00:00.000" totalcaserate="56" totalcases="214" totaldeaths="1"> 



  5. COVID-19 Cases and Deaths by Race/Ethnicity

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Race-Ethnicity/7rne-efic

     api: https://data.ct.gov/resource/7rne-efic.json


  6. COVID-19 State Summary **** Data to show on the landing page
      COVID-19 state summary including the following metrics, including the change from the data reported the previous day:

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-state-summary/ncg4-6gkj

     api: https://data.ct.gov/resource/ncg4-6gkj.json

     Hash Keys:

      measure
      total
      changedirection
      change
      dateupdated 


Some of Dwayne's popular gems 
https://dwayne.fm/rails-gems-to-consider/


Models

  User - is used by this aplication as well as the Devise gem
    
    has_many :states
    has_many :ethnic_cases
    has_many :age_groups
    has_many :gender_cases
    has_many :counties
    has_many :towns, through: :counties

    attributes
      username:string
      email:string
      query_date:datetime
      encrypted_password:string
      password_confirmation:string

      ** other Devise attributes see both model and schema **

  State

    belongs_to :user
    has_many :counties
    has_many :towns, through: :counties
    has_many :ethnic_cases


    arrtibutes
      user_id:integer
      query_date:datetime
      name:string
      total_tests:integer
      total_cases:integer
      confirmed_cases:integer
      hospitalized_cases:integer
      confirmed_deaths:integer
      test_change:integer
      case_change:integer
      hospitalized_change:integer
      death_change:integer
      test_dir:string
      case_dir:string
      hosp_dir:string
      death_dir:string


  Town
    has_many :tests
    has_many :cases
    has_many :deaths
    belongs_to :county 

    attributes
    query_date:date
    name:string
    county_id:integer


  County
    belongs_to :user
    has_many :towns

    attributes
    query_date:date     
    name:string


   GenderCase

     belongs_to :user
    
    attributes
      query_date:date 
      male_cases:integer
      female_cases:integer
      male_deaths:integer
      female_deaths:integer  
  

  EthnicCase

    belongs_to :user

    attributes
      user_id:integer
      query_date:datetime 
      ethnic_group:string
      total_pop:integer
      case_tot:integer  
      case_age_adjusted:integer         
      deaths:integer                 
      death_age_adjusted:integer

  AgeGroup
    
    belongs_to :user

    attributes 
      user_id:integer
      query_date:datetime
      age_group:integer
      total_cases:integer
      total_deaths:integer  

Views

Controllers

RSpec

Design


Minimum Viable Product

Stretch Goals

Specifications for the Rails Assessment see spec.md

