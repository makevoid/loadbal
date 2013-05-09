require 'mechanize'

class Loadbal

  # sets / unsets load balancing policy on router: TP-Link, model: TL-R470T+

  HOST = "192.168.0.1"
  USER = "admin"
  PASS = File.read(File.expand_path("~/.password")).strip.sub(/33/, '')

  def activation_url(active=true)
    "http://#{HOST}/userRpm/WanBalancePolicyRpm.htm?IpConn=#{"2" unless active}&ipConnMaxAge=360&ipConnOblAge=600&appMaxAge=600&appOblAge=1200&Save=Save"
  end

  def initialize
    @agent = Mechanize.new
    @agent.basic_auth USER, PASS
    @agent.get "http://#{HOST}"
  end

  # activate load balancing policy
  def activate
    @agent.get activation_url
  end

  # deactivates load balancing
  def deactivate
    @agent.get activation_url(false)
  end

end
