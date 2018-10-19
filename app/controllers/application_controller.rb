class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def get_graph
  	uri = URI.parse("https://pixe.la/v1/users/taskdriver/graphs/user#{current_user.id}")
  	response = Net::HTTP.get(uri)
  	is_svg = !Nokogiri.parse(response).css("svg").empty?
  	if is_svg
  		svg = Nokogiri.parse(response)
  		svg.css("rect").first.remove
  		@graph = svg.serialize
  	else
  		create_graph
  	end
  end

  def create_graph
  	uri = URI.parse("https://pixe.la/v1/users/taskdriver/graphs")
  	http = Net::HTTP.new(uri.host, uri.port)
  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	request = Net::HTTP::Post.new(uri.path)
  	request['X-USER-TOKEN'] = ENV['PIXELA_SECRET']
    request.body = '{"id":"user' + String(current_user.id) + '","name":"test","unit":"commit","type":"int","color":"shibafu"}'
  	response = http.request(request)
  	if response.code == '200'
  		get_graph
  	else
  		false
  	end
  end

  def save_commitment(date)
  	if quantity = get_pixel(date)
      update_pixel(date, quantity)
    else
      create_pixel(date)
  	end
  end

  def update_pixel(date, quantity)
    formatted_date = format_date(date)
    uri = URI.parse("https://pixe.la/v1/users/taskdriver/graphs/user#{current_user.id}/#{formatted_date}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Put.new(uri.path)
    request['X-USER-TOKEN'] = ENV['PIXELA_SECRET']
    request.body = '{"quantity":"' + String(quantity + 1) + '"}'
    response = http.request(request)
    if response.code == '200'
      response.body
    else
      false
    end
  end

  def create_pixel(date)
    formatted_date = format_date(date)
    uri = URI.parse("https://pixe.la/v1/users/taskdriver/graphs/user#{current_user.id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.path)
    request['X-USER-TOKEN'] = ENV['PIXELA_SECRET']
    request.body = '{"date":"' + formatted_date + '","quantity":"1"}'
    response = http.request(request)
    if response.code == '200'
      response.body
    else
      false
    end
  end

  def get_pixel(date)
  	formatted_date = format_date(date)
  	uri = URI.parse("https://pixe.la/v1/users/taskdriver/graphs/user#{current_user.id}/#{formatted_date}")
  	http = Net::HTTP.new(uri.host, uri.port)
  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	request = Net::HTTP::Get.new(uri.path)
  	request['X-USER-TOKEN'] = ENV['PIXELA_SECRET']
  	response = http.request(request)
  	if response.code == '200'
  		result = JSON.parse(response.body)
      result["quantity"]
  	else
  		false
  	end
  end

  def format_date(date)
    date.strftime('%Y%m%d')
  end
end
