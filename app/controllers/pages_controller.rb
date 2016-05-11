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
		@dimensions = ["Account", "Date", "Cardproducts"]
  end

  def rollup 
  	dimension = params[:dimension]
  	get_request "http://localhost:8080/api/rollup/#{dimension}"
		redirect_to :action => 'tables'
  end

  def drilldown
  	dimension = params[:dimension]
  	get_request "http://localhost:8080/api/drilldown/#{dimension}"
		redirect_to :action => 'tables'
  end

private
	def get_table
		res = get_request 'http://localhost:8080/api'
		JSON.parse(res.body)
	end	

	def get_request url
		url = URI.parse(url)
  	req = Net::HTTP::Get.new(url.to_s)
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}
	end
end
