defmodule Eurexa.EurekaV2 do
	
	@moduledoc """
	This module implements the v2 HTTP protocol of Eureka.
	"""

	alias Eurexa.EurexaServer
	@eureka_api "eureka/apps" # in Eureka Spring the v2 is eliminated 

	@behaviour Eurexa.EurekaBehaviour

	def send_heartbeat(eureka_base_url, app_name, hostname) do
        make_url(eureka_base_url, app_name, hostname)
          |> HTTPoison.put("", [])		
	end

	def deregister(eureka_base_url, app_name, hostname) do
        make_url(eureka_base_url, app_name, hostname)
		  |> HTTPoison.delete()
	end
	
	def register(eureka_base_url, %EurexaServer{} = app) do
        json = EurexaServer.make_instance_data(app)
        header = [{"content-type", "application/json"}]
		make_url(eureka_base_url, app.app, app.hostName)
            |> HTTPoison.post(json, header)
	end
	
	def make_url(eureka_base_url, app_name, hostname) do
        "#{eureka_base_url}#{@eureka_api}/#{app_name}/#{hostname}"
    end
    def make_url(eureka_base_url, app_name) do
        "#{eureka_base_url}#{@eureka_api}/#{app_name}"
    end

end