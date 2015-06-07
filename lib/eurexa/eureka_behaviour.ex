defmodule Eurexa.EurekaBehaviour do

	@moduledoc """
	Specifies the behaviour to support different Eureka versions.
	"""
	use Behaviour
	@type url_t :: String.t
	@type app_t :: String.t
	@type id_t :: String.t

	defcallback  send_heartbeat(url_t, app_t, id_t) :: any

	defcallback deregister(url_t, app_t, id_t) :: any
	
	defcallback register(url_t, %Eurexa.EurexaServer{}) :: any


end