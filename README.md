# Chat Vote Go Back End App

[Blog Post about this application](http://aleksandr-rogachev-blog.com/2017/05/26/chat_vote_go/)

Web-based chat application for users  to connect in private chat rooms, create suggestions for where to go, and vote for the best ideas. Uses ActionCable and Google Places API.

## Installation

This application uses front end application: https://github.com/AleksandrRogachev94/chat-vote-go-frontend

To launch server side app:
Clone the repository and then execute:

    $ bundle

Install postgresql on your system, create environmental variables PG_USER and PG_PASS.

## Usage

This guide is about running this application **locally** (in development environment).
Execute:

    $ rake db:migrate

If you want, you can use fake data from db/seeds.rb (you can see all necessary data including password in this file). Execute:

    $ rake db:seed

To start the server execute:

    $ rails s -p 3001

Go to http://localhost:3001.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AleksandrRogachev94/chat-vote-go-backend. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

This Web Application is available as open source under the terms of the [Apache License](http://www.apache.org/licenses/).
