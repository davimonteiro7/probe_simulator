defmodule ProbeSimulator.Probes.SendProbeTest do
  use ExUnit.Case
  alias ProbeSimulator.Probes.SendProbe
  alias ProbeSimulator.Probes.ProbeRepository

  describe "call/0" do
    test "return a tuple, if a new probe was sent." do
      response = SendProbe.call()
      expected_response = {:created, %{message: "Probe created successfully"}}
      assert response == expected_response

      ProbeRepository.delete()
    end

    test "return a tuple , if the same probe already exists " do

      SendProbe.call()
      response = SendProbe.call()
      expected_response = {:ok, %{message: "Probe has already been created"}}

      assert response == expected_response

      ProbeRepository.delete()
    end
  end
end
