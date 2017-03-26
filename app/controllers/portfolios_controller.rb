require 'descriptive_statistics'

class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def new
    @portfolio = Portfolio.new
  end

  def create
    # DATES HERE?????????????????????????????????????????
    # render json:portfolio_params
    # @portfolio_tickers = "AAPL"
    @portfolio  = Portfolio.new
    @portfolio.user = current_user
    if @portfolio.save
      flash[:notice] = 'Portfolio created successfully'
      portfolio_params[:ticker_ids].each do |x|
        p = PortfolioTicker.new
        p.ticker_id = x
        p.portfolio_id = Portfolio.last.id
        p.save
      end
      redirect_to portfolio_path(@portfolio)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end


  def show
    # DATES HERE?????????????????????????????????????????

    @portfolio = Portfolio.find params[:id]

    @ticker_array= []

    @portfolio.tickers.each do |x|
      @ticker_array << x.name
    end

    @stock = StockQuote::Stock.quote("aapl")

    @enddate = Date.today
    @startdate = @enddate - 30.days

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

    # puts @super_date_array
    # puts @super_close_array

    @date_array = []
    @close_array = []

    @date_array1 = []
    @close_array1 = []

    @date_array2 = []
    @close_array2 = []

    @super_duper_array[0].each do |stock|
      @date_array << stock.date
    end

    @super_duper_array[0].each do |stock|
      @close_array << stock.adj_close
    end

    @super_duper_array[1].each do |stock|
      @date_array1 << stock.date
    end

    @super_duper_array[1].each do |stock|
      @close_array1 << stock.adj_close
    end


    @super_duper_array[2].each do |stock|
      @date_array2 << stock.date
    end

    @super_duper_array[2].each do |stock|
      @close_array2 << stock.adj_close
    end
#######################################################
    @zip_array = []
    @super_date_array.each_with_index do |x, index|
      @zip_array << x.zip(@super_close_array[index])
    end
#######################################################

@super_variation_array = []
    @super_close_array.each_with_index do |x, index|
      @last = x[index+1]
      @variation_array = []
      count = 0
      # puts x.length
      x.each do |h|
        @variation_array << (((h/@last)-1)*100)
        @last = h
        count += 1
        if count == x.length
          # puts count
          @super_variation_array << @variation_array
        end
      end
    end

    # puts @super_variation_array.length

    @variation_array = []

    # close_array2 >> @super_close_array[2]
    @last = @super_close_array[0][1]

    @close_array.each_with_index do |x|
      @variation_array << (((x/@last)-1)*100)
      @last = x
    end

    @variation_array1 = []

    @last1 = @super_close_array[1][1]

    @close_array1.each do |x|
      @variation_array1 << (((x/@last1)-1)*100)
      @last1 = x
    end

    @variation_array2 = []

    # close_array2 >> @super_close_array[2]

    @last2 = @super_close_array[2][1]

    @close_array2.each do |x|
      @variation_array2 << (((x/@last2)-1)*100)
      @last2 = x
    end
#######################################################
    @zip_array1 = []
    @super_date_array.each_with_index do |x, index|
      @zip_array1 << x.zip(@super_variation_array[index])
    end

    # index+array.length?
#######################################################

    @stdev_array = []

    @super_close_array.each do |x|
      @stdev_array << x.standard_deviation
    end

    @varcoef_array = []

    @super_close_array.each_with_index do |x, index|
      @varcoef_array << @stdev_array[index] / @super_close_array[index].mean * 100
    end


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

    @stdev = @close_array.standard_deviation
    @stdev1 = @close_array1.standard_deviation
    @stdev2 = @close_array2.standard_deviation

    @varcoef = @stdev / @close_array.mean * 100
    @varcoef1 = @stdev1 / @close_array1.mean * 100
    @varcoef2 = @stdev2 / @close_array2.mean * 100

    @lastp = @close_array[0]
    @lastp1 = @close_array1[0]
    @lastp2 = @close_array2[0]

    @firstp = @close_array[@close_array.length-1]
    @firstp1 = @close_array1[@close_array1.length-1]
    @firstp2 = @close_array2[@close_array2.length-1]

    @return = (@lastp/@firstp-1)*100
    @return1 = (@lastp1/@firstp1-1)*100
    @return2 = (@lastp2/@firstp2-1)*100

# ###################################################
    # ONE DOLLAR TRAIL
    # return as .98 or 1.02

    @super_hundred_dollar_array = []
    @super_new_array = []
    @super_dollars_at_end_array = []

    @super_close_array.each_with_index do |x, index|
      @new_array = []
      @lastr = x[1]
      x.reverse.each do |close|
        @new_array << (close/@lastr)
        @lastr = close
      end

      @new_array.shift
      @number = 100
      @hundred_dollar_array = []

      @new_array.each do |x|
        @hundred_dollar_array << @number
        newNum = x * @number
        @number = newNum
      end

      @super_dollars_at_end_array << @number
      @super_new_array << @new_array
      @super_hundred_dollar_array << @hundred_dollar_array
    end

    @super_date_array.each do |x|
      x.shift
    end

    @zip_array2 = []

    @super_hundred_dollar_array.each_with_index do |x, index|
      @zip_array2 << @super_date_array[index].reverse.zip(@super_hundred_dollar_array[index])
    end




    @new_array = []
    @lastr = @close_array[1]

    @close_array.reverse.each do |close|
      @new_array << (close/@lastr)
      @lastr = close
    end

    @new_array.shift
    @number = 100
    @hundredDollarArray = []

    @new_array.each do |x|
      @hundredDollarArray << @number
      newNum = x * @number
      @number = newNum
    end

    @new_array1 = []
    @lastr1 = @close_array1[1]

    @close_array1.reverse.each do |close|
      @new_array1 << (close/@lastr1)
      @lastr1 = close
    end

    @new_array1.shift
    @number1 = 100
    @hundredDollarArray1 = []

    @new_array1.each do |x|
      @hundredDollarArray1 << @number1
      newNum = x * @number1
      @number1 = newNum
    end


    @new_array2 = []
    @lastr2 = @close_array2[1]

    @close_array2.reverse.each do |close|
      @new_array2 << (close/@lastr2)
      @lastr2 = close
    end

    @new_array2.shift
    @number2 = 100
    @hundredDollarArray2 = []

    @new_array2.each do |x|
      @hundredDollarArray2 << @number2
      newNum = x * @number2
      @number2 = newNum
    end

    @date_array.shift
    @date_array1.shift
    @date_array2.shift

    @zip6 = @date_array.reverse.zip(@hundredDollarArray)
    @zip7 = @date_array1.reverse.zip(@hundredDollarArray1)
    @zip8 = @date_array2.reverse.zip(@hundredDollarArray2)

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
      @data3 << {name: "#{@super_duper_array[index].first.symbol}", data: x}
    end


    @all_values = []

    @super_hundred_dollar_array.each do |x|
      @all_values += x
    end
    puts @all_values

    @minimum = @all_values.min
    @maximum = @all_values.max

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

  @min_acc_return = 0.0
  @excess_return = []

  @negative_excess_return =  []
# if return is less than 0 it is stored, else it is stored as
  @new_array.each do |ret|
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

# #############

  @min_acc_return1 = 0.0
  @excess_return1 = []
  @negative_excess_return1 =  []
  # if return is less than 0 it is stored, else it is stored as
  @new_array1.each do |ret|
    @excess_return1 << ret-1-@min_acc_return1
  end

  @excess_return1.each do |ret|
    if ret < 0
      @negative_excess_return1 << ret
    else
      @negative_excess_return1 << 0
    end
  end

  @suma1 = 0
  @negative_excess_return1.each do |neg|
    @suma1 += neg**2
  end

  @downside_risk1 = (@suma1/@negative_excess_return1.length) ** 0.5
  @average_excess_return1 = @excess_return1.mean
  @sortino1 = @average_excess_return1/@downside_risk1

# ######################

  @min_acc_return2 = 0.0
  @excess_return2 = []
  @negative_excess_return2 =  []
  # if return is less than 0 it is stored, else it is stored as
  @new_array2.each do |ret|
    @excess_return2 << ret-1-@min_acc_return2
  end

  @excess_return2.each do |ret|
    if ret < 0
      @negative_excess_return2 << ret
    else
      @negative_excess_return2 << 0
    end
  end

  @suma2 = 0
  @negative_excess_return2.each do |neg|
    @suma2 += neg**2
  end

  @downside_risk2 = (@suma2/@negative_excess_return2.length) ** 0.5
  @average_excess_return2 = @excess_return2.mean
  @sortino2 = @average_excess_return2/@downside_risk2

  @neg = []
  @negative_excess_return.each do |x|
    @neg << x*100.round
  end

  @zip_array3 = []

  @super_hundred_dollar_array.each_with_index do |x, index|
    @zip_array3 << @super_date_array[index].reverse.zip(@super_negative_excess_return[index])
  end

  @zip9 = @date_array.reverse.zip(@negative_excess_return)
  @zip10 = @date_array1.reverse.zip(@negative_excess_return1)
  @zip11 = @date_array2.reverse.zip(@negative_excess_return2)


  @sortinoGraph = []

  @zip_array3.each_with_index do |x, index|
    @sortinoGraph << {name: "#{@super_duper_array[index].first.symbol}", data: x}
  end


  #
  # @sortinoGraph = [
  #   {name: "#{@super_duper_array[0].first.symbol}", data: @zip9 },
  #   {name: "#{@super_duper_array[1].first.symbol}", data: @zip10 },
  #   {name: "#{@super_duper_array[2].first.symbol}", data: @zip11 }
  # ]

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

  private

  def portfolio_params
    params.require(:portfolio).permit([{ ticker_ids: [] }])
  end




end
