require_relative "mui_helpers"
module Components


  def progress_bar text,value
    div do
      p {text}
      progress(value: value, max: 100)
    end
  end

  def setTimeout time
     `setTimeout(function(){ #{yield} }, #{time});`
  end

  def clearTimer timer
    `clearTimeout(#{timer});`
  end
end
