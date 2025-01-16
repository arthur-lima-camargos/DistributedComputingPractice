defmodule LembreteApiWeb.Router do
  use LembreteApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
  end

  scope "/api", LembreteApiWeb do
    pipe_through :api
    # Configurando Rotas:
    # Adicionando escopo "/lembretes":
    scope "/lembretes" do
      get "/", LembretesController, :all
      get "/:id", LembretesController, :get
      post "/", LembretesController, :create
      put "/:id", LembretesController, :update
      delete "/:id", LembretesController, :delete

    end
  end

  if Application.compile_env(:lembreteApi, :dev_routes) do

    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: LembreteApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
