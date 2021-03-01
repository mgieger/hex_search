defmodule HexSearch.Core.Search do
  @hex_doc_base_url "https://hexdocs.pm/"

  def base_url(), do: @hex_doc_base_url

  def open_url(url) do
    System.cmd("open", [url])
  end

  def search(search_string) do
    open_url(@hex_doc_base_url <> search_string)
  end

  def hex_docs(), do: open_url(@hex_doc_base_url)
end
