defmodule Mix.Tasks.HexDocs do
  use Mix.Task

  alias HexSearch.Core.Search

  def run(_args) do
    Search.search("")
  end
end
