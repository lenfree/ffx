defmodule FfxWeb.Router do
  use FfxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FfxWeb do
    pipe_through :api
  end
end
