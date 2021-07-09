defmodule ProbeSimulator.Probes.ProbeRepositoryTest do
  use ExUnit.Case

  alias ProbeSimulator.Probes.ProbeRepository

  describe "insert/1" do
    test "insert a new probe on ETS table" do

      response = ProbeRepository.insert(%{ x: 0, y: 0, face: "D" })
      expected_response = true
      assert response == expected_response

      ProbeRepository.delete()
    end
  end

  describe "get/0" do
    test "return the probe inserted on ETS table" do

      ProbeRepository.insert(%{ x: 0, y: 0, face: "D" })
      response = ProbeRepository.get()

      expected_response = {:ok, %{face: "D", x: 0, y: 0}}
      assert response == expected_response

      ProbeRepository.delete()
    end
  end
end
