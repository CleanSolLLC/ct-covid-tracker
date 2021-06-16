# About Sinatra Comic Books

This is a simple Ruby app built with Sinatra that will allow you to keep track of your comic book collection.

User will have the ability to:

* Create their own account and sign in and out of their own account.
* Create one or more comic book listings.
* Add, edit or delete comic books.
* User can only create, view, edite or delete comic book listings from their own account.

## Future improvements planned:

* Create an option if the user wants to list their comic book publically
* Create something similar to a comic book exchange
* Create GUI that resembles more of a website
* Video walkthough on Youtube: https://www.youtube.com/watch?v=eB9IbeH5HXo
* Pleae visit my blog on Medium: https://medium.com/@mamark90/spiderman-to-sinatra-f62d0d5e317f


## Set Up

### Prerequisites
* Ruby
* SQLite3
* Boostrap https://getbootstrap.com/docs/4.4/getting-started/introduction/



## Development & Usage
	
### Installation

1. This repository uses the BootstrapCDN to utilize HTML formatting
2. Fork the repository and clone it.
3. Run bundle install to install gems (If you don't have bundler, first run gem install bundler)
4. Set up the database with rake db:migrate.
5. There is seed data to get you started if you choose run rake db:seed.
6. See login credentails below.
6. Run shotgun to run the app locally at http://localhost:9393/.

```
sinatra_comic_books
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── SPEC.md
├── app
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── comic_book_controller.rb
│   │   ├── user_controller.rb
│   │   └── user_controller_hold.rb
│   ├── models
│   │   ├── comic.rb
│   │   └── user.rb
│   └── views
│       ├── comics
│       │   ├── edit.erb
│       │   ├── index.erb
│       │   ├── new.erb
│       │   └── show.erb
│       ├── home.erb
│       ├── index.erb
│       ├── layout.erb
│       ├── registrations
│       │   └── signup.erb
│       └── sessions
│           └── login.erb
├── config
│   ├── database.yml
│   └── environment.rb
├── config.ru
├── db
│   ├── comics.db
│   ├── development.sqlite
│   ├── migrate
│   │   ├── 20191210202106_create_users.rb
│   │   ├── 20191214033852_create_comic_list.rb
│   │   ├── 20191214122636_update_comics_table.rb
│   │   └── 20191216000049_add_column_to_comics.rb
│   └── schema.rb
└── public
    ├── images
    │   ├── avenger.jpeg
    │   ├── batman.jpeg
    │   ├── captainamerica.jpeg
    │   ├── collage.jpeg
    │   ├── collage2.jpeg
    │   ├── deadpool.jpeg
    │   ├── fantastic4.jpeg
    │   ├── fantastic4.jpg
    │   ├── isis.jpeg
    │   ├── kapow.jpg
    │   ├── spiderman2.jpg
    │   ├── storm.jpeg
    │   ├── superman.jpeg
    │   ├── wonderwoman.jpeg
    │   ├── wonderwoman2.jpeg
    │   └── xmen.jpeg
    ├── javascripts
    └── stylesheets
```
## Login

The Seed data uses the following login:
username: GIJane@abc123.com 
password:GIJane@abc123.com 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sinatra_comic_books. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sinatra Comic Books project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sinatra_comic_books/blob/master/CODE_OF_CONDUCT.md).

