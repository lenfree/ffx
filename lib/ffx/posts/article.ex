defmodule Ffx.Posts.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :body, :binary
    field :title, :string
    field :tags, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
