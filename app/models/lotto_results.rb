class Lotto_Result
  include Mongoid::Document
  include Lotto_Results_Decorator
  field :draw_date, type: Integer
  field :printable_date, type: String
  field :numbers, type: Array
  field :bonus, type: Integer
  field :jackpot, type: String

  before_save do |document|
    document.draw_date = document.draw_date.to_i
  end

end
