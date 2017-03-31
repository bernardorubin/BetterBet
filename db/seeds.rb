# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




tickerArray = [["Apple", "AAPL"],["Google", "GOOGL"], ["Microsoft", "MSFT"],
["Facebook", "FB"], ["Amazon", "AMZN"], ["Alibaba", "BABA"],["Tesla", "TSLA"],
["Sony", "SNY"]




]


# "BRK-A",
# "JNJ",
# "XOM",
# "JPM",
# "WFC",
# "GE",
# "T",
# "BAC",
# "PG",
# "CHL",
# "BUD",
# "WMT",
# "RDS-A",
# "V",
# "CVX",
# "VZ",
# "PFE",
# "ORCL",
# "KO",
# "HD",
# "DIS",
# "CMCSA",
# "NVS",
# "MRK",
# "PM",
# "CSCO",
# "TSM",
# "INTC",
# "IBM",
# "C",
# "PEP",
# "HSBC",
# "UNH",
# "UL",
# "MO",
# "CX",
# "AMGN",
# "BTI",
# "TOT",
# "CCV",
# "MA",
# "SAP",
# "MMM",

User.create(email: 'bernardorubin@gmail.com', password: 'chichi', timezone: 'America/Los_Angeles')

tickerArray.each do |x, y|
  Ticker.create(name: x, ticker: y)
end
