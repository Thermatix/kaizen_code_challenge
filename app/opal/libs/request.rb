require 'browser/http'
class Request
  class << self

    # Validates given #validation request against [Forms::Tree] object validations
    #
    # @param argname [Symbol] reference to [Forms::Tree] object
    # @return [[{Symbol => String,Number}]] hash containing formatted response message

    # @macro [attach] define_method
    #   @method $1
    #  (see #make)
    %w{get post delete put patch head}.each do |http_verb|
      define_method http_verb do |*args,&block|
        self.make(http_verb,*args,&block)
      end
    end

    # makes a request to the given url
    #   make :post,'some/url/end/point', {some: 'data'} do |request|
    #     request.on(:success)
    #     request.on(:failure)
    #   end
    #
    # @param type [Symbol] of request to make
    # @param url [String] of requet to make
    # @param payload [{Symbol => Hash,String,Number,Boolean}] of request to make
    def make(type,url,payload=nil, &block)
      Browser::HTTP.send type, url, payload do |request|
        request.content_type 'application/json'
        if block_given?
          block.call(*request)
        else
          request
        end
      end
    end
  end
end
