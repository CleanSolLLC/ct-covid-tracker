# About CT-Covid-Tracker

This is a Rails application that allows users to research Connecticut COVID-19 data at the state, county and town level. The user can also research data based on gender, race/etnicity and age group.

Data is accessed via the State of Connecticut COVID-19 Data portal https://data.ct.gov/browse?tags=covid-19 using the Socrata Open Data API (SODA) https://dev.socrata.com/. The application utilizes the Soda-Ruby gem to access data through api endpoints and allows for the writing of SQL-like statements to return values from various datasets. Please read the notes.md file for more information on the datasets and the models used in this application. An entity relationship diagram is also provided (erd.pdf).

### Note that the data is cumulative and depending on breaks in time periods in between queries it may be worthwhile to delete data and rerun queries to interpret the graph results. 


The user will have the ability to:

* Create/delete their own account and sign in and out of their own account with a username and password.
* Sign in to their own account using their Google login credentials.
* Input dates and other input parameters to run queries within various State of Connecticut COVID-19 datasets.
* View line charts that are dynamically created based on the values returned by the dataset queried.
* Create, edit, and delete posts that can be read by other users.
* Comment on posts written by other users.
* Create, view, edit or delete data from their own account.


* Video walkthrough on Youtube: https://youtu.be/NFiGJOWFtJc
* Please visit my blog on Medium: https://medium.com/p/4ef3e19a4cc5
* The application is hosted on Heroku: https://stark-ocean-74969.herokuapp.com


## Future improvements planned:

* Extend the application to provide additional search criteria based on vaccination rates.
* Allow the user to save queries in differnt formats such as .pdf and .csv.
* Provide other graphing options such as bar charts, scatter plots, etc.
 

## Set Up

### Prerequisites
* Ruby 2.7
* Rails 6.0
* PostgreSQL 12 or later


## Development & Usage
  
### Installation

1. This repository uses the Bulma for css styling.
2. Fork the repository and clone it.
3. Run bundle install to install gems (If you don't have bundler, first run gem install bundler)
4. Set up the database with rake db:migrate.e r
5. You will need to install the dotenv-rails gem and set up a .env file in the root directory.
6. Store the database user name and password in environment variables in the .env file.
7. Request a Google client id and a Google client secret to store in the .env file
   https://www.rubydoc.info/gems/omniauth-google-oauth2/0.2.5/frames 
8. Add the .env file to .gitignore so that it is not added to your file structure on github   
9. Run rails s (server) to run the app locally at http://localhost:3000


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CleanSolLLC/ct-covid-tracker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ct-covid-tracker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/CleanSolLLC/ct-covid-tracker/blob/master/CODE_OF_CONDUCT.md).

