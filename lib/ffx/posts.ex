defmodule Ffx.Posts do
  use(Xarango.Domain.Document)

  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Ffx.Repo

  alias Ffx.Posts.Article

  @doc """
  Gets a single article.

  ## Examples

      iex> get_article!(123)
      %%Ffx.Posts{}

  """
  def get_article!(id) do
    one(%{_key: id})
  end

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

  """
  def create_article(attrs \\ %{}) do
    # TODO: add validation
    {:ok, create(attrs)}
  end
end
