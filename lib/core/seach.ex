defmodule HexSearch.Core.Search do
  @hex_doc_base_url "https://hexdocs.pm/"

  def base_url(), do: @hex_doc_base_url

  def open_url(url) do
    System.cmd("open", [@hex_doc_base_url <> url])
  end

  def search({_module, _function} = args) do
    args
    |> build_search_url()
    |> open_url()
  end

  def search(search_string) when is_binary(search_string) do
    open_url(search_string)
  end

  defp build_search_url({module, nil}) do
    parse_module(module) <> ".html"
  end

  defp build_search_url(args) do
    {module, function} = args

    parse_module(module) <> ".html##{function}"
  end

  defp parse_module(module) do
    module
    |> String.split(".", trim: true)
    |> case do
      [module] -> "#{String.downcase(module)}/#{String.capitalize(module)}"
      [module, sub_module] -> "#{String.downcase(module)}/#{String.capitalize(module)}.#{String.capitalize(sub_module)}"
    end
  end
end
