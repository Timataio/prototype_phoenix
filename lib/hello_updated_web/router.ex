defmodule HelloUpdatedWeb.Router do
  use HelloUpdatedWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
	plug :put_layout, false
    plug :fetch_session
    plug :fetch_live_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloUpdatedWeb do
    pipe_through :browser

	get "/home", GreetingController, :greetlist
	get "/greeting/:greeting", GreetingController, :customgreeting
	
	post "/home", GreetingController, :newgreeting
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloUpdatedWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hello_updated, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloUpdatedWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
