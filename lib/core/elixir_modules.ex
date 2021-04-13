defmodule HexSearch.Core.ElixirModules do
  @core_modules %{
    "access" => "Access",
    "agent" => "Agent",
    "application" => "Application",
    "atom" => "Atom",
    "base" => "Base",
    "behaviour" => "Behaviour",
    "bitwise" => "Bitwise",
    "calendar" => "Calendar",
    "code" => "Code",
    "collectable" => "Collectable",
    "config" => "Config",
    "date" => "Date",
    "datetime" => "DateTime",
    "dict" => "Dict",
    "dynamicsupervisor" => "DynamicSupervisor",
    "enum" => "Enum",
    "enumerable" => "Enumerable",
    "exception" => "Exception",
    "file" => "File",
    "float" => "Float",
    "function" => "Function",
    "genevent" => "GenEvent",
    "genserver" => "GenServer",
    "hashdict" => "HashDict",
    "hashset" => "HashSet",
    "inspect" => "Inspect",
    "integer" => "Integer",
    "io" => "IO",
    "kernel" => "Kernel",
    "keyword" => "Keyword",
    "list" => "List",
    "macro" => "Macro",
    "map" => "Map",
    "mapset" => "MapSet",
    "module" => "Module",
    "naivedatetime" => "NaiveDateTime",
    "node" => "Node",
    "optionparser" => "OptionParser",
    "path" => "Path",
    "port" => "Port",
    "process" => "Process",
    "protocol" => "Protocol",
    "range" => "Range",
    "record" => "Record",
    "regex" => "Regex",
    "registry" => "Registry",
    "set" => "Set",
    "stream" => "Stream",
    "string" => "String",
    "stringio" => "StringIO",
    "supervisor" => "Supervisor",
    "system" => "System",
    "task" => "Task",
    "time" => "Time",
    "tuple" => "Tuple",
    "uri" => "URI",
    "version" => "Version"
  }

  def core_modules() do
    @core_modules
  end

  def core_module_keys() do
    Enum.reduce(@core_modules, [], fn {module, _value}, acc -> [module] ++ acc end)
  end
end
