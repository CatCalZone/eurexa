defmodule Eurexa.EurekaV1 do
	@moduledoc """
	This module implements the protocol of the Eureka version 1 interface.
	"""

	alias Eurexa.EurexaServer
	@behaviour Eurexa.EurexaBehaviour

	def send_heartbeat(eureka_base_url, app_name, hostname) do
    header = [{"content-type", "application/json"}]
    make_url(eureka_base_url, app_name)
    |> HTTPoison.post("", header)
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
    "#{eureka_base_url}/refresh/#{app_name}/#{hostname}"
  end

  def make_url(eureka_base_url, app_name) do
    "#{eureka_base_url}/refresh/#{app_name}"
  end
end
