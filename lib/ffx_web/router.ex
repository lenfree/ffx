defmodule FfxWeb.Router do
  use FfxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FfxWeb do
    pipe_through :api

    post "/articles", ArticleController, :create
    get "/articles/:id", ArticleController, :show
    get "/tags/:tagname/:date", TagController, :show
  end
end
