defmodule EurexaTest do
  use ExUnit.Case

  alias Eurexa.EurexaServer

  test "make a full URL" do
  	app = "myapp"
  	hostname = "eurexa.catcal.zone"
  	eureka_host = "eureka.catcal.zone"
  	base_url = "http://#{eureka_host}:8761/eureka/v2/apps"

  	assert "http://#{eureka_host}:8761/eureka/v2/apps/#{app}/#{hostname}" == 
  		EurexaServer.make_url(base_url, app, hostname)
  end

  test "make a post URL" do
  	app = "myapp"
  	# hostname = "eurexa.catcal.zone"
  	eureka_host = "eureka.catcal.zone"
  	base_url = "http://#{eureka_host}:8761/eureka/v2/apps"

  	assert "http://#{eureka_host}:8761/eureka/v2/apps/#{app}" == 
  		EurexaServer.make_url(base_url, app)
  end

end
