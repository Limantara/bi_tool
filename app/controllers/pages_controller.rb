require 'net/http'

class PagesController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
		@table = get_table
  end

  def charts
  end

  def tables
		@table = get_table
		@dimensions = ["Accounts", "Dates", "Cardproducts"]
  end

private
	def get_table
		url = URI.parse('http://localhost:8080/api')
  	req = Net::HTTP::Get.new(url.to_s)
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}
		JSON.parse(res.body)
	end	
end
