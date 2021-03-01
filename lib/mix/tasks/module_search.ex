defmodule Mix.Tasks.ModuleSearch do
  use Mix.Task

  alias HexSearch.Core.Search

  @shortdoc "searches the hex documentation for a specified module"

  @aliases [f: :function, fun: :function, m: :module, mod: :module]
  @types [function: :string, module: :string]

  def run([]) do
    Search.search("elixir/")
  end

  def run(args) do
    {parsed_args, string_args, _} = OptionParser.parse(args, aliases: @aliases, strict: @types)

    {module, function} = extract_string_args(string_args)

    module = parsed_args[:module] || module
    function = parsed_args[:function] || function

    {module, function}
    |> build_search_url
    |> Search.search()
  end

  defp build_search_url({module, nil}) do
    parse_module(module) <> ".html"
  end

  defp build_search_url(args) do
    {module, function} = args

    parse_module(module) <> ".html##{function}"
  end

  defp extract_string_args(string_args) do
    case string_args do
      [] -> {nil, nil}
      [module] -> {module, nil}
      [module | function] -> {module, function}
    end
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
