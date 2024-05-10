defmodule HelloUpdated.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloUpdatedWeb.Telemetry,
      HelloUpdated.Repo,
      {DNSCluster, query: Application.get_env(:hello_updated, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloUpdated.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloUpdated.Finch},
      # Start a worker by calling: HelloUpdated.Worker.start_link(arg)
      # {HelloUpdated.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloUpdatedWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloUpdated.Supervisor]
	{:ok, agent} = Agent.start_link(fn -> default_list() end, name: :greetings)
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloUpdatedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
  
  def default_list() do
	[%Greeting{text: "Hello", inventor: "God"}, %Greeting{text: "こんいちは", inventor: "神"}, %Greeting{text: "Good tidings to you.", inventor: "Santa"}, %Greeting{text: "Yo", inventor: "Some random guy"}]
  end
end
