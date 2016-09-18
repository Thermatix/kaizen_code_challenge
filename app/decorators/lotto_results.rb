module Lotto_Results_Decorator
  Dates = [
    DateTime.new(2013,10).to_i,
    DateTime.new(2015,10).to_i,
    DateTime.new(2015,10).to_i
  ].freeze

  MC = {
    before_2013_oct: [true,false,false],
    before_2015_oct: [false,true,false],
    after_2015_oct: [false,false,true],
    gt_three: [true,false],
    eq_two: [false,true]
  }.freeze

  Lesser_Prizes ={
     MC[:before_2013_oct] + MC[:gt_three] => "£10",
     MC[:before_2013_oct] + MC[:eq_two] => nil,
     MC[:before_2015_oct] + MC[:gt_three] => "£25",
     MC[:before_2015_oct] + MC[:eq_two] => nil,
     MC[:after_2015_oct] + MC[:gt_three] => "£25",
     MC[:after_2015_oct] + MC[:eq_two] => 'One free Lotto Lucky Dip'
  }.freeze

  Threshold = 3
  JackPot_Match_Threshold = 6
  Is_Number = /\A[-+]?\d+\z/
  Zero = 0

  def prize numbers=nil,bonus_number=nil
    @prize ||= if winner? numbers, bonus_number
      d_date = self.draw_date
      match_count = by_how_many?(numbers)
      if match_count + bonus? >= JackPot_Match_Threshold
        self.jackpot
      else
        Lesser_Prizes.fetch([between(Dates[0]..Dates[1],d_date),between(Dates[1]..Dates[2],d_date),beyond(Dates[2],d_date),match_count >= Threshold,match_count < Threshold - 1],nil)
      end
    else
      false
    end
  end

  def prize_to_i
    @numberised ||= @prize[1..(@prize.length - 1)].gsub(',','')
    if @numberised =~ Is_Number
      @numberised.to_i
    else
      Zero
    end
  end


  private

  def winner? numbers,bonus_number
    by_how_many?(numbers) + bonus?(bonus_number) >= Threshold
  end

  def between date_range,value
    date_range === value
  end

  def beyond  date,value
    date < value
  end

  def by_how_many? numbers_arg
    @matches ||= JackPot_Match_Threshold - (self.numbers - numbers_arg).length
  end

  def bonus? number=nil
    @bonus ||= (self.bonus == number) ? 1 : 0
  end

end
