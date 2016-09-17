defmodule Canary.Storage.Filesystem do
  @spec save(String.t, String.t, String.t) :: {:ok, term} | {:error, :file.posix}
  def save(location, name, content) do
    location <> name
    |> File.open([:write], fn file ->
      IO.write file, content
    end)
  end

  @spec load(String.t, String.t) :: String.t
  def load(location, name) do
    {:ok, contents} = location <> name
    |> File.open([:read], fn file ->
      IO.read file, :all
    end)

    contents
  end
end
