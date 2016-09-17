defmodule Canary.WebUI.Action do
  @type hound_action :: :fill | :click | :submit | :visit
  @type hound_target :: {term, String.t}
  @type t :: %__MODULE__{action: hound_action, target: hound_target, data: nil | String.t}

  defstruct [:action, :target, :data]

  @spec houndify(__MODULE__.t) :: String.t
  def houndify(%__MODULE__{action: :visit, data: data}) do
    "navigate_to(#{Kernel.inspect(data)})"
  end
  def houndify(%__MODULE__{action: :fill, target: target, data: data}) do
    "fill_field(#{Kernel.inspect(target)}, #{Kernel.inspect(data)})"
  end
  def houndify(%__MODULE__{action: :click, target: target}) do
    "click(#{Kernel.inspect(target)})"
  end
  def houndify(%__MODULE__{action: :submit, target: target}) do
    "submit_element(#{Kernel.inspect(target)})"
  end


  def intern(line), do: do_intern(String.strip(line), %__MODULE__{})

  defp do_intern("", action), do: action
  defp do_intern(<< ")", rest::binary >>, action), do: do_intern(rest, action)
  defp do_intern(<< "navigate_to(", rest::binary >>, action) do
    do_intern(rest, Kernel.struct(action, action: :visit))
  end
  defp do_intern(<< "fill_field(", rest::binary >>, action) do
    do_intern(rest, Kernel.struct(action, action: :fill))
  end
  defp do_intern(<< "click(", rest::binary >>, action) do
    do_intern(rest, Kernel.struct(action, action: :click))
  end
  defp do_intern(<< "submit_element(", rest::binary >>, action) do
    do_intern(rest, Kernel.struct(action, action: :submit))
  end
  defp do_intern(<< "{", rest::binary >>, action) do
    {rest, target} = parse_target(rest, {"", ""})

    do_intern(rest, Kernel.struct(action, target: target))
  end
  defp do_intern(<< " \"", rest::binary >>, action) do
    {rest, data} = parse_data(rest, "")

    do_intern rest, Kernel.struct(action, data: data)
  end
  defp do_intern(<< "(\"", rest::binary >>, action) do
    {rest, data} = parse_data(rest, "")

    do_intern rest, Kernel.struct(action, data: data)
  end

  defp parse_target(<< "})", rest::binary >>, {attr, value}), do: {rest, {String.to_atom(attr), value}}
  defp parse_target(<< "},", rest::binary >>, {attr, value}), do: {rest, {String.to_atom(attr), value}}
  defp parse_target(<< ":", rest::binary >>, {attr, value}) do
    {rest, attr} = read_attr(rest, attr)

    parse_target rest, {attr, value}
  end
  defp parse_target(<< " \"", rest::binary >>, {attr, value}) do
    {rest, value} = read_value(rest, value)

    parse_target rest, {attr, value}
  end

  defp read_attr(<< ",", rest::binary >>, attr), do: {rest, attr}
  defp read_attr(<< char::size(8), rest::binary >>, attr), do: read_attr(rest, attr <> <<char>>)

  defp read_value(<< "\"", rest::binary >>, value), do: {rest, value}
  defp read_value(<< char::size(8), rest::binary >>, value), do: read_value(rest, value <> <<char>>)

  defp parse_data(<< "\"", rest::binary >>, data), do: {rest, data}
  defp parse_data(<< char::size(8), rest::binary >>, data), do: parse_data(rest, data <> <<char>>)
end
