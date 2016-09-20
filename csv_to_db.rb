require 'csv'
require 'mongoid'

root_path = File.dirname(__FILE__)

Mongoid.load!("#{root_path}/mongoid.yml", :development )

CSV.foreach("lotto_res.csv",{headers: false}) do |lotto_res|
  d,d2 = lotto_res[0].split('|')
  lr = Lotto_Result.new(
    {
      draw_date: DateTime.new(*d[0].split(',').map(&:to_i)),
      printable_date: d2,
      numbers: lotto_res[1..6].map {|e| e.to_i},
      bonus: lotto_res[7].to_i,
      jackpot: lotto_res[8]
    }
  )
  lr.save

end
