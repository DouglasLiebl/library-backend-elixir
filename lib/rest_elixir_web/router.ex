defmodule RestElixirWeb.Router do
  use RestElixirWeb, :router


  ## PIPELINES
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :header_check do
    plug RestElixirWeb.Auth.TokenFilter
  end

  pipeline :user_privileges do
    plug RestElixirWeb.Auth.RoleFilter, role: "ROLE_USER"
  end

  pipeline :manager_privileges do
    plug RestElixirWeb.Auth.RoleFilter, role: "ROLE_MANAGER"
  end

  pipeline :admin_privileges do
    plug RestElixirWeb.Auth.RoleFilter, role: "ROLE_ADMIN"
  end

  ## ENDPOINTS
  # Open
  scope "/api", RestElixirWeb do
    pipe_through :api

    post "/register", UserController, :create
    post "/login", UserController, :login

    get "/book", BookController, :index
    get "/book/:id", BookController, :show
  end

  # User Privileges
  scope "/api/users", RestElixirWeb do
    pipe_through [:api, :header_check, :user_privileges]

    # User Related
    get "/users/:email", UserController, :show

    # Loan Related
    post "/loans", LoanController, :create
  end

  # Manager Privileges
  scope "/api/managers", RestElixirWeb do
    pipe_through [:api, :header_check, :manager_privileges]

    # Book Related
    post "/book", BookController, :create
    put "/book", BookController, :update
    delete "/book", BookController, :delete
  end

  # Admin Privileges
  scope "/api/admin", RestElixirWeb do
    pipe_through [:api, :header_check, :admin_privileges]

    # To Do resources impls
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
