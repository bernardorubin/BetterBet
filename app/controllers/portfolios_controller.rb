require 'descriptive_statistics'
class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    if @user == current_user
      @portfolios = @user.portfolios
    else
      redirect_back fallback_location: root_path, alert: 'Back'
    end
  end

  def update
    @portfolio = Portfolio.find params[:id]
      if @portfolio.update(portfolio_params)
        flash[:notice] = 'Portfolio updated successfully'
        redirect_to portfolio_path
      end
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    date = Date.new portfolio_params["startdate(1i)"].to_i, portfolio_params["startdate(2i)"].to_i, portfolio_params["startdate(3i)"].to_i
    # render json:portfolio_params
    @portfolio  = Portfolio.new
    @portfolio.startdate = date
    @portfolio.user = current_user
    if @portfolio.save
      flash[:notice] = 'Portfolio created successfully'
      portfolio_params[:ticker_ids].each do |x|
        p = PortfolioTicker.new
        p.ticker_id = x
        # TODO fix below for many users
        p.portfolio_id = Portfolio.last.id
        p.save
      end
      redirect_to portfolio_path(@portfolio)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

# Add validations for seeds and everything
# Track the bet?
# Add cancan so noone can see other bets status maybe?
# add state machine
# TODO check in Portfolio show if th portfolio si in an active bet

  def show
    # graph portfolio performance
    # Set dates in request as 1 week etc, not by exact date
    # DATES HERE?????????????????????????????????????????
    @portfolio = Portfolio.find params[:id]

    @enddate = Date.today
    # @startdate = @enddate - 30.days
    @startdate = @portfolio.startdate
# NOT DRY
    @ticker_array= []

    @portfolio.tickers.each do |x|
      @ticker_array << x.ticker
    end
#
    @super_duper_array = []

    # b = Benchmark.measure do
    @ticker_array.each do |ticker|
      @super_duper_array << StockQuote::Stock.history("#{ticker}", "#{@startdate}", "#{@enddate}")
    end
    # end
    # puts "*** time: #{b}"

    @super_date_array = []
    @super_close_array = []

    @super_duper_array.each_with_index do |hist, index|
      @datearray = []
      @closearray = []
      hist.each do |stock|
        @datearray << stock.date
        @closearray << stock.adj_close
      end
      @super_date_array << @datearray
      @super_close_array << @closearray
    end

#######################################################
    @zip_array = []
    @super_date_array.each_with_index do |x, index|
      @zip_array << x.zip(@super_close_array[index])
    end
#######################################################

    @super_variation_array = []

    @super_close_array.each_with_index do |x, index|
      @last = x[1]
      @variation_array = []
      count = 0
      # puts x.length
      x.each do |h|
        @variation_array << (((@last/h)-1)*100)
        @last = h
        count += 1
      end
      @super_variation_array << @variation_array
    end


#######################################################
    @zip_array1 = []
    @super_date_array.each_with_index do |x, index|
      @zip_array1 << x.zip(@super_variation_array[index])
    end

    # index+array.length?
#######################################################
# TECHNICAL RATIOS
    @stdev_array = []

    @super_close_array.each do |x|
      @stdev_array << x.standard_deviation
    end

    @varcoef_array = []

    @super_close_array.each_with_index do |x, index|
      @varcoef_array << @stdev_array[index] / @super_close_array[index].mean * 100
    end

    @zip_inter = @ticker_array.zip(@varcoef_array)
    @zip_inter = @zip_inter.sort_by{|x,y|y}

    @lastp_array = []

    @super_close_array.each do |x|
      @lastp_array << x[0]
    end

    @firstp_array = []

    @super_close_array.each_with_index do |x, index|
      @firstp_array <<  @super_close_array[index][@super_close_array[index].length-1]
    end

    @return_array = []

    @super_close_array.each_with_index do |x, index|
      @return_array << (@lastp_array[index]/@firstp_array[index]-1)*100
    end

    @zip_return = @ticker_array.zip(@return_array)
    @zip_return = @zip_return.sort_by{|x,y|y}.reverse


# ###################################################
    # ONE DOLLAR TRAIL

    @super_hundred_dollar_array = []
    @super_new_array = []
    @super_dollars_at_end_array = []

    @super_close_array.each_with_index do |x, index|
      @new_array = []
      @lastr = x[1]
      x.each do |close|
        @new_array << (@lastr/close)
        @lastr = close
      end

      @new_array

      @number = 100.0
      @hundred_dollar_array = []

      @new_array.reverse.each do |x|
        @hundred_dollar_array << @number
        newNum = x * @number
        @number = newNum
      end

      @final_number = @hundred_dollar_array[-1]

      @super_dollars_at_end_array << @final_number
      @super_new_array << @new_array
      @super_hundred_dollar_array << @hundred_dollar_array
    end

    # @super_date_array.each do |x|
    #   x.shift
    # end
    @portfolio_return = @super_hundred_dollar_array.transpose

    @portfolio_average = []

    @portfolio_return.each do |average|
      @portfolio_average << average.sum / average.size.to_f
    end

    @super_date_array << @super_date_array.last
    @super_hundred_dollar_array << @portfolio_average
    @ticker_array << "PORTFOLIO"

    @zip_array2 = []

    @super_hundred_dollar_array.each_with_index do |x, index|
      @zip_array2 << @super_date_array[index].reverse.zip(@super_hundred_dollar_array[index])
    end



##########################################################
    @data1 = []

    @zip_array.each_with_index do |x, index|
      @data1 << {name: "#{@super_duper_array[index].first.symbol}", data: x}
    end

    @data2 = []

    @zip_array1.each_with_index do |x, index|
      @data2 << {name: "#{@super_duper_array[index].first.symbol}", data: x}
    end

    @data3 = []


    @zip_array2.each_with_index do |x, index|
      @data3 << {name: "#{@ticker_array[index]}", data: x}
    end

    @all_values = []

    @super_hundred_dollar_array.each do |x|
      @all_values += x
    end

    @minimum = @all_values.min
    @maximum = @all_values.max

# REMOVED FROM PORTFOLIO
    @ticker_array.pop
    @super_date_array.pop
    @portfolio_last = @super_hundred_dollar_array.last.last
    @super_hundred_dollar_array.pop

    @zip_dollars = @ticker_array.zip(@super_dollars_at_end_array)
    @zip_dollars = @zip_dollars.sort_by{|x,y|y}.reverse
# #############################################
# SORTINO RATIO

    @super_downside_risk= []
    @super_average_excess_return= []
    @super_sortino= []
    @super_negative_excess_return = []

    @super_new_array.each_with_index do |ret, index|
      @min_acc_return = 0.0
      @excess_return = []
      @negative_excess_return =  []

      ret.each do |ret|
        @excess_return << ret-1-@min_acc_return
      end

      @excess_return.each do |ret|
        if ret < 0
          @negative_excess_return << ret
        else
          @negative_excess_return << 0
        end
      end

      @suma = 0
      @negative_excess_return.each do |neg|
        @suma += neg**2
      end

      @downside_risk = (@suma/@negative_excess_return.length) ** 0.5
      @average_excess_return = @excess_return.mean
      @sortino = @average_excess_return/@downside_risk

      @super_downside_risk << @downside_risk
      @super_average_excess_return << @average_excess_return
      @super_sortino << @sortino
      @super_negative_excess_return << @negative_excess_return
    end


    @zip_array3 = []

    @super_hundred_dollar_array.each_with_index do |x, index|
      @zip_array3 << @super_date_array[index].reverse.zip(@super_negative_excess_return[index])
    end

    @sortinoGraph = []

    @zip_array3.each_with_index do |x, index|
      @sortinoGraph << {name: "#{@super_duper_array[index].first.symbol}", data: x}
    end

    @zip_sortino = @ticker_array.zip(@super_sortino)
    @zip_sortino = @zip_sortino.sort_by{|x,y|y}.reverse


    # fundamental

    @fundamental_array = []

    @ticker_array.each do |ticker|
      # refactor with only one request
      @fundamental_array << StockQuote::Stock.quote("#{ticker}")
    end

    @zip_fundamental = @ticker_array.zip(@fundamental_array)
    @zip_fundamental = @zip_fundamental#.sort_by{|x,y|y}.reverse

  end

  private

  def portfolio_params
    params.require(:portfolio).permit([:startdate, { ticker_ids: [] }])
  end

  # DRAW DB ERD 🌶
  # DRAW DB mockup 🌶

  # graph should ignore empty days (weekends)
  # Query database monthly when range is higher than x amount
    # METAS
      # store all stock information data in DB
      # 1 análisis técnico cabrón ✅
      # 2 mejores visuales con monedas
      # 3 análisis fundamental con gurus probably
      # 4 gurus
      # 5 apuestas con otras personas y board
      # 6 agregar deportes
      # 7 el usuario hace sus propias reglas gurus incluyendo analisis tecnoco y fundamental

    # ratio que contempla upside sin
    # en invenet no le importa el upside aca si

    # puedes hacer un super gurú con todos los tests
    # fusión de gurús

    # adjust lower axis values and colors
    # Add basic stocks ratios
    # Add fundamental analysis
    # add guru analysis

    # @var

    # haces una apuesta q es lo mismo q de deportes pero tiene todo otro módulo de análisis
    # módulo de análisis de deportes


    # informate lee noticias
    # estas son las noticias
    # a menos de q estés tradeando opciones puedes conservar tu posición no hay margin call

    # Add ability to bet on stocks and soccer games
    # list all challenges made by people

    # referir a donde se vende la acción
    # retar a mi amigo despues de hacer mi analisis con mis gurus

    # analisis fundamental (noticias)
    # el usuario pone sus propias reglas de scraping y lo capturamos nosotros
    # tecnico

    # MAKE STOCKS ACCESSIBLE TO EVERYONE

    # CHECK CORRELATIONS

    # If I invested one dollar how much would i have now?

    # Divide last price between first

    # If we only account the stddev downside variation
    # Or upside

    # SHARPE

    # PORTFOLIO IMPLEMENTATION? we are looking to implement modern portfolio thoery

    # @ac = @close_array1[@close_array1.length-1]

    # puts @variation_array

    # IMPLEMENT sports betting

    # to_date = today.strftime("%Y-%m-%d")
end
