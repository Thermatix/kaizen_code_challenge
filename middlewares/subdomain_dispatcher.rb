# subdomain dispatching middleware
class Subdomain_Dispatcher

  def initialize(app,&block)
    @app = app
    @domains = {}
    @ssl = false
    @subs = []
    @errors = {
      ssl: ['403', {'Content-Type' => 'text/html'}, ['Forbidden, This resource is HTTPS only']]
    }
    instance_exec(&block)
  end

  def ssl_only
    @ssl = true
    yield
    @ssl = false
  end

  def set domain,app
    @subs << (d = domain.to_s)
    @domains[d] = {
        app: app,
        ssl: @ssl
    }

  end

  def call(env)
    sub = subdomain(env)
    if @subs.include?(sub)
      if @domains[sub][:ssl]
        if env['rack.url_scheme'] == 'https'
          @domains[sub][:app].call(env)
        else
        @errors[:ssl]
        end
      else
        @domains[sub][:app].call(env)
      end
    else
      @app.call(env)
    end
  end



  private
  def subdomain(env)
    env['HTTP_HOST'].split('.').first
  end

end
