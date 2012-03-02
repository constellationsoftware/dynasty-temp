class Capybara::Server
  def self.manual_host=(value)
    @manual_host = value
  end
  def self.manual_host
    @manual_host ||= 'localhost'
  end

  def url(path)
    if path =~ /^http/
      path
    else
      (Capybara.app_host || "http://#{Capybara::Server.manual_host}:#{port}") + path.to_s
    end
  end
end