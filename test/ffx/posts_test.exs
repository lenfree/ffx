defmodule Ffx.PostsTest do
  alias Ffx.Posts
  use ExUnit.Case

  describe "articles" do
    alias Ffx.Posts

    @valid_attrs %{
      date: "20200304",
      tags: [
        "sports",
        "general"
      ],
      text: "whatever hello body",
      title: "whatever"
    }

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_article()
      article
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert article == Posts.get_article!(String.replace(article.doc._id, "ffx_posts/", ""))
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Ffx.Posts{} = article} = Posts.create_article(@valid_attrs)
      assert article.doc._data.text == "whatever hello body"
      assert article.doc._data.title == "whatever"
    end
  end
end
