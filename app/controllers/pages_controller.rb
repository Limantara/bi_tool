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

  def slice
  	dimension = params[:dimension]
  	where1 = params[:where1]
  	where1Value = params[:where1Value]
  	res = get_request "http://localhost:8080/api/slice/#{dimension}/#{where1}/#{where1Value}"
  	redirect_to :action => 'tables', :table => res.body
  end

  def add_dimension
    dimension = params[:dimension]
    get_request "http://localhost:8080/api/add/#{dimension}"
    redirect_to :action => 'tables'

  end

  def remove_dimension
    dimension = params[:dimension]
    get_request "http://localhost:8080/api/remove/#{dimension}"
    redirect_to :action => 'tables'

  end  
  
private
	def get_table
		res = get_request 'http://localhost:8080/api'
    empty_table = '{"header":[],"body":[]}'

    if valid_json? res.body
		  JSON.parse(res.body) 
    else  
      JSON.parse(empty_table)
    end
	end	

	def get_request url
		url = URI.parse(url)
  	req = Net::HTTP::Get.new(url.to_s)
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}
	end

  def valid_json?(json)
    begin
      JSON.parse(json)
      return true
    rescue JSON::ParserError => e
      return false
    end
  end
end
