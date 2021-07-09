defmodule ProbeSimulator.Probes.SendProbe do

  alias ProbeSimulator.Probes.ProbeRepository

  def call() do
    probe = %{
      x: 0,
      y: 0,
      face: "D"
    }

    case ProbeRepository.insert(probe) do
      true  ->  {:created, %{message: "Probe created successfully"}}
      false ->  {:ok, %{message: "Probe has already been created"}}
     {:error, reason}  ->  {:bad_request, %{message: reason}}
    end
  end
end
