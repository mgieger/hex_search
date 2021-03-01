defmodule Mix.Tasks.HexSearch do
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

    Search.search({module, function})
  end

  defp extract_string_args(string_args) do
    case string_args do
      [] -> {nil, nil}
      [module] -> {module, nil}
      [module | function] -> {module, function}
    end
  end
end
