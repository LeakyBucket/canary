defmodule Canary.WebUI.Acceptance do
  @type acceptance_target :: :body | {term, String.t}
  @type t :: %__MODULE__{type: :is | :is_not, target: acceptance_target, value: String.t}
  defstruct [:type, :target, :value]

  def houndify(crit = %__MODULE__{type: :is}) do
    "String.contains?(inner_html(#{Kernel.inspect(crit.target)}), #{Kernel.inspect(crit.value)})"
  end
  def houndify(crit = %__MODULE__{type: :is_not}) do
    "!String.contains?(inner_html(#{Kernel.inspect(crit.target)}), #{Kernel.inspect(crit.value)})"
  end
end
