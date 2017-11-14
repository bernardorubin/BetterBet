# Better Bets

This was my graduation final project at CodeCore.

It uses several advanced rails features.

The app serves the purpose of a virtual bookkeeper.

It has two main areas:

* Sports Bets
* Stocks Bets

Stock Bets is the most complex system it allows the user to create his own stock
portfolio after using the analysis tools available such as ->

* Fetch historical stock prices and current financial data from their financial statements
* See current news relevant to the company
* See financial charts comparing any group of stocks selected by the user
* Graph your portfolio's historical performance

After the user chooses their portfolio of stocks they can publish it, set a wager and bet against other users.

Sports bets are similar in that you can see future fixtures for your favorite team and publish a bet that other users can see and bet against.

App Built with these elements ->

* Rails

* Active Job

* Delayed Job

* RSS Feed News Integration

* Chartkick

* State Machine

* Devise for Authentication with OAuth Facebook Integration

* Cancancan for Authorization

To deploy ->

* Install Ruby, and Rails

* `bundle install`

* `rails db:create`

* `rails db:migrate`

* `rails db:seed`

* `rails s`
