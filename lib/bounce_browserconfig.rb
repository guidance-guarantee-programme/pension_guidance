class BounceBrowserconfig
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/browserconfig.xml'
      [404, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]
    else
      @app.call(env)
    end
  end
end
