defmodule EurexaTest do
  use ExUnit.Case

  alias Eurexa.EurexaServer
  alias Eurexa.EurekaV2

  test "make a full URL" do
  	app = "myapp"
  	hostname = "eurexa.catcal.zone"
  	eureka_host = "eureka.catcal.zone"
  	base_url = "http://#{eureka_host}:8761/"# "eureka/v2/apps"

  	assert "http://#{eureka_host}:8761/eureka/apps/#{app}/#{hostname}" ==
  		EurekaV2.make_url(base_url, app, hostname)
  end

  test "make a post URL" do
  	app = "myapp"
  	# hostname = "eurexa.catcal.zone"
  	eureka_host = "eureka.catcal.zone"
  	base_url = "http://#{eureka_host}:8761/"

  	assert "http://#{eureka_host}:8761/eureka/apps/#{app}" ==
  		EurekaV2.make_url(base_url, app)
  end

  test "json data for registering" do
  	app = %EurexaServer{}
  	json = EurexaServer.make_instance_data(app)

  	assert ~r{"app" *: *"my_app"} |> Regex.match?(json)
    assert ~r{"hostName" *: *"localhost"} |> Regex.match?(json)
    assert ~r{"ipAddr" *: *"127.0.0.1"} |> Regex.match?(json)
  end

  test "empty worker definition" do
    assert [] == Eurexa.workers([])
  end

  test "single not existing worker definition" do
    assert [] == Eurexa.workers(:i_am_not_configured)
  end

  test "single existing worker definition" do
    mod = EurexaServer
    assert [{^mod, {^mod, :start_link, [:eurexa]}, _, _, :worker, _}] = Eurexa.workers(:eurexa)
  end

  test "mixture of  existing and not existing worker definitions" do
    mod = EurexaServer
    assert [{^mod, {^mod, :start_link, [:eurexa]}, _, _, :worker, _}] = Eurexa.workers([:eurexa, :i_am_not_configured])
  end
end
