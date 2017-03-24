require 'descriptive_statistics'
class HomeController < ApplicationController
  def index
    @stock = StockQuote::Stock.quote("aapl")

    @date_array = []
    @close_array = []

    @date_array1 = []
    @close_array1 = []

    @date_array2 = []
    @close_array2 = []

    @enddate = Date.today
    @startdate = @enddate - 100.days

    b = Benchmark.measure do
      @stocks = StockQuote::Stock.history('aapl', "#{@startdate}", "#{@enddate}")
      @stocks1 = StockQuote::Stock.history('tsla', "#{@startdate}", "#{@enddate}")
      @stocks2 = StockQuote::Stock.history('amzn', "#{@startdate}", "#{@enddate}")
    end

    puts "*** time: #{b}"

    @stocks.each do |stock|
      @date_array << stock.date
    end

    @stocks.each do |stock|
      @close_array << stock.adj_close
    end

    @stocks1.each do |stock|
      @date_array1 << stock.date
    end

    @stocks1.each do |stock|
      @close_array1 << stock.adj_close
    end


    @stocks2.each do |stock|
      @date_array2 << stock.date
    end

    @stocks2.each do |stock|
      @close_array2 << stock.adj_close
    end
#######################################################
    @zip = @date_array.zip(@close_array)
    @zip1 = @date_array1.zip(@close_array1)
    @zip2 = @date_array2.zip(@close_array2)
#######################################################

    @variation_array = []
    @last = @close_array[1]

    @close_array.each do |x|
      @variation_array << (((x/@last)-1)*100)
      @last = x
    end

    @variation_array1 = []
    @last1 = @close_array1[1]

    @close_array1.each do |x|
      @variation_array1 << (((x/@last1)-1)*100)
      @last1 = x
    end

    @variation_array2 = []
    @last2 = @close_array2[1]

    @close_array2.each do |x|
      @variation_array2 << (((x/@last2)-1)*100)
      @last2 = x
    end
#######################################################
    @zip3 = @date_array.zip(@variation_array)
    @zip4 = @date_array1.zip(@variation_array1)
    @zip5 = @date_array2.zip(@variation_array2)
#######################################################

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
      @newNum = x * @number
      @number = @newNum
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
      @newNum = x * @number1
      @number1 = @newNum
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
      @newNum = x * @number2
      @number2 = @newNum
    end


    @zip6 = @date_array.reverse.zip(@hundredDollarArray)
    @zip7 = @date_array1.reverse.zip(@hundredDollarArray1)
    @zip8 = @date_array2.reverse.zip(@hundredDollarArray2)





    @data1 = [
      {name: "#{@stocks.first.symbol}", data: @zip },
      {name: "#{@stocks1.first.symbol}", data: @zip1 },
      {name: "#{@stocks2.first.symbol}", data: @zip2 }
      ]

    @data2 = [
      {name: "#{@stocks.first.symbol}", data: @zip3 },
      {name: "#{@stocks1.first.symbol}", data: @zip4 },
      {name: "#{@stocks2.first.symbol}", data: @zip5 }
      ]

    @data3 = [
      {name: "#{@stocks.first.symbol}", data: @zip6 },
      {name: "#{@stocks1.first.symbol}", data: @zip7 },
      {name: "#{@stocks2.first.symbol}", data: @zip8 }
      ]

    @all_values = @hundredDollarArray + @hundredDollarArray1 + @hundredDollarArray2
    @minimum = @all_values.min
    @maximum = @all_values.max

# #############################################
# SORTINO RATIO



    # METAS
      # 1 anásisis técnico
      # 2 mejores visuales con monedas
      # 3 análisis fundamental
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
end
