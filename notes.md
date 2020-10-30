CT-COVID-TRACKER PROJECT

Flatiron 

https://www.loom.com/share/9e066894c613463684bc094694a9fa09


Use of several apis:

  1. COVID-19 Tests, Cases, Hospitalizations, and Deaths (Statewide)
     https://data.ct.gov/Health-and-Human-Services/COVID-19-Tests-Cases-Hospitalizations-and-Deaths-S/rf3k-f8fg  

     api: https://data.ct.gov/resource/rf3k-f8fg.json 

  2. COVID-19 Tests, Cases, and Deaths (By Town)
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Tests-Cases-and-Deaths-By-Town-/28fr-iqnx

     api: https://data.ct.gov/resource/28fr-iqnx.json

  3. COVID-19 Cases and Deaths by Gender
     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Gender/qa53-fghg

     api: https://data.ct.gov/resource/qa53-fghg.json

  4. COVID-19 Cases and Deaths by Age Group

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Age-Group/ypz6-8qyf

     api: https://data.ct.gov/resource/ypz6-8qyf.json

  5. COVID-19 Cases and Deaths by Race/Ethnicity

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-and-Deaths-by-Race-Ethnicity/7rne-efic

     api: https://data.ct.gov/resource/7rne-efic.json

  6. COVID-19 Cases, Hospitalizations, and Deaths (By County)

     web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-Cases-Hospitalizations-and-Deaths-By-Coun/bfnu-rgqt

     api: https://data.ct.gov/resource/bfnu-rgqt.json

  7. COVID-19 PCR-Based Test Results by Date of Specimen Collection (By County)

      web page: https://data.ct.gov/Health-and-Human-Services/COVID-19-PCR-Based-Test-Results-by-Date-of-Specime/qfkt-uahj

      api: https://data.ct.gov/resource/qfkt-uahj.json


Some of Dwayne's popular gems 
https://dwayne.fm/rails-gems-to-consider/


Models
  User
  has_many :data_points
  has_many :covid_stats, through: :data_points

  attributes
  *** SEE DEVISE DOCUMENTATION FOR OTHER ATTRIBUTES **
  username:string
  email:string
  password:string
  password_confirmation:string

  DataPoint (Join Table)
    belongs_to :user
    belongs_to :covid_stat

    attributes
    query_datdate
    user_id:int
    covidstat_id


  CovidStat (Join Table)
  ## Using SQL Joins ??? ##
    belongs_to :datapoint
    belongs_to :town
    belongs_to :county
    belongs_to :state

    attributes
    query_date:date
    datapoint_id:integer
    state_id:integer
    county_id:integer
    town_id:integer


  State
    has_many :tests
    has_many :cases
    has_many :deaths
    has_many :hospitalizations 

    ### The AR Association we want is state.cases.gender_cases ###
    has_many :gender_data, through: gender_cases

    ### The AR Association we want is state.cases.ethnic_cases ###
    has_many :ethnic_data, through: ethnic_cases

    ### The AR Association we want is state.cases.age_group_cases ###
    has_many :age_group_data, through: age_group_cases

    arrtibutes
    query_date:date
    name:string


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
    has_many :towns
    has_many :tests
    has_many :cases
    has_many :deaths
    has_many :hospitalizations  

    attributes
    query_date:date     
    name:string
      

  Test
    belongs_to :state
    belongs_to : county
    belongs_to :town

    attributes
    query_date:date 
    state_id:integer
    town_id:integer
    county_id: integer
    num_tests:integer

  Case
    belongs_to :state
    belongs_to :county
    belongs_to :town    

    attributes
    query_date:date 
    state_id:integer
    county_id:integer
    town_id:integer
    num_cases:integer


  Death
    belongs_to :state
    belongs_to :county    
    belongs_to :town

    attributes
    query_date:date 
    state_id:integer
    county_id:integer
    town_id:integer    
    num_deaths:integer       

  Hospitalization
    belongs_to :state
    belongs_to :county 

    attributes
    query_date:date 
    state_id:integer
    county_id:integer
    num_hospitalizations:integer   


  GenderCase (Join Table)

    belongs_to :state
    belongs_to :gender_data

    attributes
    state_id:integer
    gender_data_id:integer

   GenderDatum
    
    attributes
    query_date:date 
    male_cases:integer
    female_cases:integer
    male_deaths:integer
    female_deaths:integer  
  

  EthnicCase (Join Table)

    belongs_to :state
    belongs_to :ethnic_data

    attributes 
    state_id:integer
    ethnic_data_id:integer

    EthnicDatum

    attributes
    query_date:date 
    cases_hispanic:integer
    cases_NH_American_Indian_or_Alaskan_Native:integer
    cases_NH_Asian_or_Pacific_Islander:integer
    cases_NH_Black:integer
    cases_NH_Multracial:integer
    cases_NH_White:integer
    cases_NH_Other:integer
    cases_Unknown:integer 

    deaths_hispanic:integer
    deaths_NH_American_Indian_or_Alaskan_Native:integer
    deaths_NH_Asian_or_Pacific_Islander:integer
    deaths_NH_Black:integer
    deaths_NH_Multracial:integer
    deaths_NH_White:integer
    deaths_NH_Other:integer
    deaths_Unknown:integer 


  AgeGroupCase (Join Table)
    
    belongs_to :state
    belongs_to :age_group_data

    attributes 
    state_id:integer
    age_group_data_id:integer

  AgeGroupData
  
    attributes
    query_date:string 
    cases_0_9:integer
    cases_10_19:integer
    cases_20_29:integer
    cases_30_39:integer
    cases_40_49:integer
    cases_50_59:integer
    cases_60_69:integer
    cases_70_79:integer
    cases_80_and_older:integer

    deaths_0_9:integer
    deaths_10_19:integer
    deaths_20_29:integer
    deaths_30_39:integer
    deaths_40_49:integer
    deaths_50_59:integer
    deaths_60_69:integer
    deaths_70_79:integer
    deaths_80_and_older:integer 


Views

Controllers

RSpec

Design


Minimum Viable Product

Stretch Goals

Specifications for the Rails Assessment see spec.md

