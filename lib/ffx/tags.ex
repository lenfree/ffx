defmodule Ffx.Tags do
  use(Xarango.Domain.Document)

  @moduledoc """
  The Tag context.
  """
  @doc """
  Gets a summary based from article tag and date.

  ## Examples

      iex> search_by_tag_and_date!("health", "20121230")
      %%Ffx.Posts{}

  """
  def search_by_tag_and_date!(tag = value, date) do
    #    convert YYYYMMDD to YYYY-MM-DD
    ## TODO: Validate date format
    field = "tags"
    query = "
      FOR doc IN FULLTEXT(\"ffx_posts\", \"#{field}\", \"prefix:#{value}\")
        FILTER doc.date == \"#{date}\"
        COLLECT countTags = COUNT(doc.tags) INTO group
        LET count = LENGTH(group),
        total = COUNT_UNIQUE(group[*].doc.tags) + 1
      RETURN {
        \"tag\": \"#{value}\",
        \"articles\": group[*].doc._id,
        \"count\": count,
        \"related_tags\": group[*].doc.tags
      }"

    %Xarango.Query{
      query: query,
      batchSize: 3
    }
    |> Xarango.Query.query(_database())
    |> Map.get(:result)
    |> to_document
  end
end
