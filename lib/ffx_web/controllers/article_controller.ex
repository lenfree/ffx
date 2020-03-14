defmodule FfxWeb.ArticleController do
  use FfxWeb, :controller

  alias Ffx.Posts
  alias Ffx.Posts.Article

  action_fallback FfxWeb.FallbackController

  def create(conn, %{"article" => article_params}) do
    %{article_params | date: Date.from_iso8601(article_params["date"])}

    with {:ok, %Ffx.Posts{} = article} <- Posts.create_article(article_params) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Posts.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def show(conn, %{"id" => id}) do
    article = Posts.get_article!(id)
    render(conn, "show.json", article: article)
  end
end
