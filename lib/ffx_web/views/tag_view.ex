defmodule FfxWeb.TagView do
  use FfxWeb, :view
  alias FfxWeb.TagView

  def render("show.json", %{data: document}) do
    %{data: render_one(document, TagView, "tag.json")}
  end

  def render("tag.json", %{data: [result|_tail]}) do
    # A document returns
    # [
    #  %Ffx.Posts{
    #    doc: %Xarango.Document{
    #      _data: %{
    #        articles: ["ffx_posts/22244", "ffx_posts/22278", "ffx_posts/23136",
    #         "ffx_posts/23702", "ffx_posts/24069", "ffx_posts/24467"],
    #        count: 6,
    #        related_tags: [
    #          ["health", "general"],
    #          ["sports", "general"],
    #          ["media", "general"],
    #          ["media", "general"],
    #          ["media", "general"],
    #          ["media", "general"]
    #        ],
    #        tag: "general"
    #      },
    #      _id: nil,
    #      _key: nil,
    #      _oldRev: nil,
    #      _rev: nil
    #    }
    #  }
    # ]

    # data.result returns a list and since we get an aggregation and
    # list return size of 1, we want to return non list json format.

    data = result.doc._data
    data = %{data | related_tags: get_unique_tags(data, data.tag)}
    data = %{data | articles: filter_out_table_name(data)}

    %{
      tag: data.tag,
      count: data.count,
      articles: data.articles,
      related_tags: data.related_tags
    }
  end

  # TODO: properly return empty json. Maybe use schema to properly populate this?
  def render("tag.json", %{data: document}) do
    %{}
  end

  def get_unique_tags(tags, tag) do
    tags
    |> Map.get(:related_tags)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.reject(fn name -> name == tag end)
  end

  def filter_out_table_name(tags) do
    tags
    |> Map.get(:articles)
    |> Enum.map(&String.replace(&1, "ffx_posts/", ""))
  end
end
