defmodule Eurexa do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Eurexa.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Eurexa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Creates the Eurexa worker definitions for various apps given as parameter. 
  It is checked that a configuration for those apps exists and only for 
  existing configurations the worker specs are created. 

  This helpful for testing and dev environemnts where potenitally the 
  Eurexa configuraiton is not available yet starting the application 
  should be done alway in the same way 
  """
  @spec workers(atom | [atom]) :: [term]
  def workers(app) when is_atom(app), do: workers([app]) 
  def workers(apps) when is_list(apps) do
    import Supervisor.Spec, warn: false
    apps 
      |> Enum.filter(fn app -> nil != Application.get_env(:eurexa, app) end)
      |> Enum.map(fn app -> worker(Eurexa.EurexaServer, [app]) end)
  end
  
end
