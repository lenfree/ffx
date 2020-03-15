defmodule Ffx.TagsTest do
  alias Ffx.Tags
  use ExUnit.Case

  describe "tags" do
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

    # Improve test case due to time constraint.
    test "search_by_tag_and_date!/2 returns a summary" do
      article = article_fixture()
    [%{doc: data}] = Tags.search_by_tag_and_date!("general", article.doc._data.date)
    assert Enum.count(data._data.articles) >= 1
    end
  end
end
