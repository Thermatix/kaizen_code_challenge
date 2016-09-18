require_relative 'component_helpers'
module Components
  class Base
    def initialize(native)
      @native = native
    end

    def self.render(args = {}, &block)
      React::RenderingContext.render(self, *args, &block)
    end

    def method_missing(meth,*args,&block)
      if meth =~ /(get|post|put|delete)_(.*)/
        api_request $1,$2,(args ? args.first : nil),&block
      else
        super
      end
    end

    def api_request action,item,data=nil,&block
      Request.send(action,"/api/#{item}",data) do |request|
        handle_response_for request do |response|
          block.call(response.json)
        end
      end
    end

    def paramaterize(hash)
      if hash.keys.empty?
        ""
      else
        "?#{hash.map {|k,v| "#{k}=#{v}"}.join('&')}"
      end
    end

    def self.inherited(child)
      child.include ::React::Component
    end

    def label_for(id,text=nil,hash={})
      label(*{html_for: id, id: "#{id}_label"}.merge!(hash)){text || id}
    end

    def handle event,*args
      field = yield
      field.on(event) {|e|send("handle_#{event}",e,*args)}
      return field
    end

    def handle_response_for request
      request.on :success do |response|
        yield(response)
      end
      request.on :failure do |response|
        puts "request fail"
        puts request.inspect
      end
    end

  end
end
