defmodule RestElixirWeb.Router do
  use RestElixirWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :header_check do
    plug RestElixirWeb.Auth.TokenFilter
  end

  pipeline :super_user do
    plug RestElixirWeb.Auth.SuperUserFilter
  end

  scope "/api/books", RestElixirWeb do
    pipe_through :api

    resources "/", BookController
  end

  scope "/api/users", RestElixirWeb do
    pipe_through [:api]

    post "/", UserController, :create
    get "/:email", UserController, :show
  end

  scope "/api", RestElixirWeb do
    pipe_through :api

    post "/login", UserController, :login
  end

  scope "/api/loans", RestElixirWeb do
    pipe_through :api

    resources "/", LoanController
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:rest_elixir, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RestElixirWeb.Telemetry
    end
  end
end
