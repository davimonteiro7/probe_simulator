defmodule ProbeSimulator.Probes.GetProbe do
  alias ProbeSimulator.Probes.ProbeRepository

  def call() do
    result = ProbeRepository.get()

    case result do
      {:ok, result } -> {:ok, result}
      {:error, reason} -> {:bad_request, %{message: reason}}
    end
  end
end
