# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




tickerArray = [["Apple", "AAPL"],["Google", "GOOGL"], ["Microsoft", "MSFT"],
["Facebook", "FB"], ["Amazon", "AMZN"], ["Alibaba", "BABA"],["Tesla", "TSLA"],
["Sony", "SNY"], ["HSBC", "HSBC"]

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


# teamsArray = [["Manchester United", 66],["Tottenham", 73],["Borussia Dortmund", 4],["Real Madrid CF", 86],["Club Atlético de Madrid", 78], ["FC Barcelona", 81]]
#
# teamsArray.each do |x, y|
#   Soccerteam.create(name: x, team_id: y)
# end

User.create(email: 'bernardorubin@gmail.com', password: 'chichi', timezone: 'America/Los_Angeles')

tickerArray.each do |x, y|
  Ticker.create(name: x, ticker: y)
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')



# SEED TEAMS


@res = FootballData.fetch(:competitions)

@competition_ids = []

@res.each do |x|
  @competition_ids << x["id"]
end

@competition_teams =[]

@competition_ids.each do |x|
  @res1 = FootballData.fetch(:competitions, :teams, id: x)
  if @res1["error"]
    sleep(40)
    @res1 = FootballData.fetch(:competitions, :teams, id: x)
  end
  @competition_teams << @res1["teams"]
end

@all_teams = []

@competition_teams.each do |x|
  x.each do |x|
    @all_teams << x["id"]
  end
end

@all_teams.each do |x|
  puts x
  @res = FootballData.fetch(:teams, "/", id: x)
  if @res["error"]
    sleep(40)
    @res = FootballData.fetch(:teams, "/", id: x)
  end
  @newteam = Soccerteam.new
  @newteam.name = @res["name"]
  @newteam.team_id = @res["id"]
  @newteam.image = @res["crestUrl"]
  @newteam.save
  puts @res
end
