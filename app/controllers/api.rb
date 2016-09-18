require 'grape'
require 'json'
class API < Grape::API
  Errors = {
    arg: { error: "ArgumentError", message: "'numbers' or 'bonus_number' not present"},
    type: {error: "TypeError", message: "args not of correct type"}
  }.freeze
   content_type :json, "application/json; charset=utf-8"
  format :json
  @@p_cache = {}

  helpers do

    def delimit_number(number)
      number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end

    def format_success(result)
      {
        success: true,
        numbers: params[:numbers],
        bonus: params[:bonus_number],
        total: "£#{delimit_number(result.inject(0) {|tot,res| tot + res.prize_to_i})}",
        results: result.map do |res|
           {
             jackpot: res.prize,
            date: res[:printable_date]
          }
        end
      }
    end


  end

  post '/winner' do
    params =  JSON.parse(env["rack.input"].read).symbolize_keys #Turn this into middleware
    if !(params[:numbers] && params[:bonus_number])
      status 422
      return Errors[:arg]
    elsif !(params[:numbers].to_i && params[:bonus_number].to_i)
      status 422
      return Errors[:type]
    end
    numbers = params[:numbers].split(',').map(&:to_i)
    result = Lotto_Result.all.inject([]) do |res,lotto_num|
      if lotto_num.prize(numbers,params[:bonus_number])
         res << lotto_num
      end
      res
    end
    if !result.empty?
      format_success(result)
    else
      {
        alert: "no match",
        message: "No matching numbers were found"
      }
    end
  end

  get '/comics' do
    params = transform_params({characters: :name, series: :title, events: :name})
    res =  marvel_request_client("comics",params).make_request
    if res
      format_response(res)
    else
      alert_response(:invalidSearch,'No comics were found matching the given title')
    end
  end

end
