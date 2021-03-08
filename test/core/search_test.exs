defmodule HexSearch.Core.SearchTest do
  use ExUnit.Case

  alias HexSearch.Core.Search

  test "module and sub_module can be uppercase" do
    assert Search.build_search_url({"Ecto.Changeset", "assoc/2"}) == "ecto/Ecto.Changeset.html#assoc/2"
  end

  describe "When module is not 'elixir' or a core language module," do
    setup [:ecto_module]

    test "It builds the module url", %{module: module} do
      assert Search.build_search_url({module, nil}) == "ecto/Ecto.html"
    end

    test "It builds the url when a module and function are provided", %{module: module} do
      assert Search.build_search_url({module, "assoc/2"}) == "ecto/Ecto.html#assoc/2"
    end

    test "It builds the url when a module with a sub-module is provided", %{module: module} do
      assert Search.build_search_url({module <> ".changeset", nil}) == "ecto/Ecto.Changeset.html"
    end

    test "It builds the url when a module, sub-module, and function is provided", %{module: module} do
      assert Search.build_search_url({module <> ".changeset", "cast/4"}) == "ecto/Ecto.Changeset.html#cast/4"
    end
  end

  describe "When module is 'elixir'," do
    setup [:elixir_module]

    test "It builds the module url", %{module: module} do
      assert Search.build_search_url({module, nil}) == "elixir/Kernel.html"
    end

    test "It builds the url when a module and function are provided", %{module: module} do
      assert Search.build_search_url({module, "apply/2"}) == "elixir/Kernel.html#apply/2"
    end

    test "It builds the url when a module with a sub-module is provided", %{module: module} do
      assert Search.build_search_url({module <> ".enum", nil}) == "elixir/Enum.html"
    end

    test "It builds the url when a module, sub-module, and function is provided", %{module: module} do
      assert Search.build_search_url({module <> ".enum", "apply/2"}) == "elixir/Enum.html#apply/2"
    end
  end

  describe "When module is a core language module," do
    setup [:enum_module]

    test "It builds the module url", %{module: module} do
      assert Search.build_search_url({module, nil}) == "elixir/Enum.html"
    end

    test "It builds the url when a module and function are provided", %{module: module} do
      assert Search.build_search_url({module, "at/3"}) == "elixir/Enum.html#at/3"
    end
  end

  defp elixir_module(context) do
    {:ok, Map.put(context, :module, "elixir")}
  end

  defp enum_module(context) do
    {:ok, Map.put(context, :module, "enum")}
  end

  defp ecto_module(context) do
    {:ok, Map.put(context, :module, "ecto")}
  end
end
