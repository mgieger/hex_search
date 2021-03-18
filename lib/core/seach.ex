defmodule HexSearch.Core.Search do
  alias HexSearch.Core.ElixirModules

  @hex_doc_base_url "https://hexdocs.pm/"

  def base_url(), do: @hex_doc_base_url

  defp open_url(url) do
    System.cmd("open", [@hex_doc_base_url <> url])
  end

  def search(args) when is_tuple(args) do
    args
    |> build_search_url()
    |> open_url()
  end

  def search(search_string) when is_binary(search_string) do
    open_url(search_string)
  end

  def build_search_url(args) do
    {module, function} = args

    module =
      module
      |> uncapitalize()
      |> parse_module()

    generate_url({module, function})
  end

  defp generate_url({module, nil}) do
    create_module_string(module) <> ".html"
  end

  defp generate_url({module, function}) do
    create_module_string(module) <> ".html##{function}"
  end

  defp parse_module(module) do
    module
    |> String.split(".", trim: true)
  end

  defp create_module_string("elixir"), do: create_module_string("elixir", "Kernel")

  defp create_module_string(module) when is_binary(module) do
    case String.downcase(module) in ElixirModules.core_module_keys do
      true ->
        module = Map.get(ElixirModules.core_modules, String.downcase(module), module)
        create_module_string("elixir", module)

        false ->
          create_module_string(module, module)
    end
  end

  defp create_module_string([module]) do
    create_module_string(module)
  end

  defp create_module_string(arg_list) do
    [module, sub_module] = arg_list

    case String.downcase(module) == "elixir" do
      true -> create_module_string("elixir", sub_module)
      false -> create_module_string(module, module) <> (".#{String.capitalize(sub_module)}")
    end
  end

  defp create_module_string(mod_one, mod_two) do
    "#{String.downcase(mod_one)}/#{capitalize(mod_two)}"
  end

  defp capitalize(word) do
    (String.slice(word, 0, 1) |> String.upcase()) <> String.slice(word, 1..-1)
  end

  defp uncapitalize(word) do
    (String.slice(word, 0, 1) |> String.downcase()) <> String.slice(word, 1..-1)
  end
end
