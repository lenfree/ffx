defmodule FfxWeb.TagController do
  use FfxWeb, :controller
use Timex
  alias Ffx.Tags

  action_fallback FfxWeb.FallbackController

  # {
  #  "tag" : "health",
  #  "count" : 17,
  #    "articles" :
  #      [
  #        "1",
  #        "7"
  #      ],
  #    "related_tags" :
  #      [
  #        "science",
  #        "fitness"
  #      ]
  # }
  def show(conn, %{"tagname" => tag, "date" => date}) do
    # Validate date with. Ff invalid return error. Otherwise,
    # proceed with search.

    data = Tags.search_by_tag_and_date!(tag, parse_date_to_iso8601(date))
    render(conn, "tag.json", data: data)
  end

  def parse_date_to_iso8601(date) do
    Timex.parse!(date, "{YYYY}{D}{M}")
     |> Date.to_string()
    #"#{d.year}-#{d.month}-#{d.day}"
  end
end
