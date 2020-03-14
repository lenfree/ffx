defmodule FfxWeb.ArticleView do
  use FfxWeb, :view
  alias FfxWeb.ArticleView

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, ArticleView, "article.json")}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{
      id: String.replace(article.doc._id, "ffx_posts/", ""),
      title: article.doc._data.title,
      text: article.doc._data.text,
      date: article.doc._data.date,
      tags: article.doc._data.tags
    }
  end
end
