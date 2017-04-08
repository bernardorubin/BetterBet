# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




tickerArray = [["Apple", "AAPL", "https://www.shareicon.net/download/128x128//2015/09/18/642803_apple_512x512.png"],
                ["Google", "GOOGL", "https://www.shareicon.net/download/128x128//2015/09/25/107085_google_512x512.png"],
                ["Microsoft", "MSFT", "https://www.shareicon.net/download/128x128//2015/09/15/101548_microsoft_512x512.png"],
                ["Facebook", "FB", "https://www.shareicon.net/download/128x128//2016/07/02/634605_facebook_512x512.png"],
                ["Amazon", "AMZN", "https://www.shareicon.net/download/128x128//2016/10/18/844584_pay_512x512.png"],
                ["Alibaba", "BABA", "https://www.shareicon.net/download/128x128//2015/09/01/94049_alibaba_512x512.png"],
                ["Tesla", "TSLA", "https://www.shareicon.net/download/128x128//2015/09/01/94010_tesla_512x512.png"],
                ["Sony", "SNY", "https://www.shareicon.net/download/128x128//2015/09/01/93997_sony_512x512.png"],
                ["HSBC", "HSBC", "https://www.shareicon.net/download/128x128//2016/07/08/117092_online_512x512.png"]
              ]


# apple
# google
# msft
# fbook
# amzn
# alibaba
# tesla
# sony
# hsbc

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

tickerArray.each do |x, y, z|
  Ticker.create(name: x, ticker: y, image: z)
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
