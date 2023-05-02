defmodule TaskManagerWeb.Router do
  use TaskManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session

    plug Guardian.Plug.Pipeline,
      module: TaskManager.Guardian,
      error_handler: TaskManagerWeb.ErrorHandler

    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  pipeline :authenticated_api do
    plug :api
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", TaskManagerWeb do
    pipe_through :api

    resources "/sessions", SessionController, only: [:create], singleton: true
  end

  scope "/api", TaskManagerWeb do
    pipe_through :authenticated_api

    resources "/sessions", SessionController, only: [:delete], singleton: true
    resources "/user", CurrentUserController, only: [:show], singleton: true
    resources "/users", UsersController, except: [:new, :edit]
    resources "/tasks", TasksController, except: [:new, :edit]
    resources "/tags", TagsController, except: [:new, :edit]
  end

  scope "/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :task_manager,
      swagger_file: "swagger.json"
  end

  def swagger_info, do: TaskManagerWeb.ApiDoc.Info.swagger_info()

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:task_manager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TaskManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
