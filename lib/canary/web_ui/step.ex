defmodule Canary.WebUI.Step do
  alias Canary.WebUI.Action

  @type t :: %__MODULE__{name: String.t, actions: list(Action.t)}
  defstruct name: "", actions: []

  @spec finalize(__MODULE__.t) :: {:ok, term} | {:error, :file.posix}
  def finalize(step) do
    Kernel.apply(storage_mod, :save, [step_dir, step.name, translate_actions(step)])
  end

  @spec load(String.t) :: __MODULE__.t
  def load(step_name) do
    step = %__MODULE__{name: step_name}

    actions = storage_mod
    |> Kernel.apply(:load, [step_dir, step_name])
    |> String.strip
    |> String.split("\n  ")
    |> Enum.reduce([], fn line, actions ->
      [Action.intern(line) | actions]
    end)
    |> Enum.reverse

    Kernel.struct(step, actions: actions)
  end

  @spec translate_actions(__MODULE__.t) :: String.t
  def translate_actions(step) do
    step.actions
    |> Enum.map(fn action ->
      Action.houndify(action)
    end)
    |> Enum.join("\n    ")
  end

  @spec available_steps() :: list(String.t)
  def available_steps do
    {:ok, steps} = File.ls(step_dir)

    steps
  end

  def storage_mod do
    Application.get_env(:canary, :persist_strategy)
  end

  @spec step_dir() :: String.t
  defp step_dir do
    Application.get_env(:canary, :step_directory) || "priv/browser/steps/"
  end
end
