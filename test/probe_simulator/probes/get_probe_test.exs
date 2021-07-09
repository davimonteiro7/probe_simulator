defmodule ProbeSimulator.Probes.GetProbeTest do
  use ExUnit.Case

  alias ProbeSimulator.Probes.GetProbe
  alias ProbeSimulator.Probes.ProbeRepository
  alias ProbeSimulator.Probes.SendProbe

  describe "call/0" do
    test "return a tuple {:ok, probe}, if exist a valid probe." do

      SendProbe.call()
      response = GetProbe.call()
      expected_response = {:ok, %{face: "D", x: 0, y: 0}}

      assert response  == expected_response

      ProbeRepository.delete()
    end

    test "return a error, if try retrieve a nonexistent probe" do

      response = GetProbe.call()
      expected_response = {:bad_request, %{message: "This probe was not created."}}

      assert response == expected_response

      ProbeRepository.delete()
    end
  end
end
