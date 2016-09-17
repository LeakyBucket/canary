defmodule Canary.WebUI.Test do
  alias Canary.WebUI.Step
  alias Canary.WebUI.Acceptance

  @type t :: %__MODULE__{name: String.t, steps: list(Step.t), acceptances: list(Acceptance.t)}
  defstruct [name: "", steps: [], acceptances: []]

  @spec save(__MODULE__.t) :: {:ok, String.t} | {:error, term}
  def save(test) do
    Kernel.apply(storage_mod, :save, [tests_dir, name_to_filename(test.name) <> ".exs", module_string(test)])
  end

  @spec to_module(__MODULE__.t) :: term
  def to_module(test) do
    [{mod, _}] = Code.compile_string module_string(test)

    mod
  end

  @spec module_string(__MODULE__.t) :: String.t
  def module_string(test) do
    """
    defmodule Canary.Browser.#{name_to_mod(test.name)} do
      use Hound.Helpers

      def run do
        #{test_actions(test.steps)}

        #{test_acceptances(test.acceptances)}
      end
    end
    """
  end

  @spec test_actions(list(Step.t)) :: String.t
  defp test_actions(steps) do
    steps
    |> Enum.map(fn step ->
      Step.translate_actions(step)
    end)
    |> Enum.join("\n\n    ")
  end

  @spec test_acceptances(list(Acceptance.t)) :: String.t
  defp test_acceptances(acceptances) do
    acceptances
    |> Enum.map(fn acceptance ->
      Acceptance.houndify(acceptance)
    end)
    |> Enum.join(" && ")
  end

  @spec name_to_mod(String.t) :: String.t
  defp name_to_mod(name) do
    name
    |> String.split(" ")
    |> Enum.map(fn part ->
      first_letter = String.first(part)

      part
      |> String.replace(first_letter, String.upcase(first_letter), global: false)
    end)
    |> Enum.join
  end

  @spec name_to_filename(String.t) :: String.t
  defp name_to_filename(name) do
    name
    |> String.split(" ")
    |> Enum.join("_")
  end

  @spec tests_dir() :: String.t
  defp tests_dir do
    Application.get_env(:canary, :browser_test_directory) || "priv/browser/tests/"
  end

  defp storage_mod do
    Application.get_env(:canary, :persist_strategy)
  end
end
