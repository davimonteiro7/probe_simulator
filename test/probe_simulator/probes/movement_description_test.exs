defmodule ProbeSimulator.Probes.MovementDescriptionTest do
  use ExUnit.Case

  alias ProbeSimulator.Probes.MovementDescription

  describe "call/1" do
    test "apply GD command, and return a move description" do
      probe_info = {{[], 0}, {" girou para a direita,", :turn}}

      response = MovementDescription.call(probe_info)
      expected_response = {[{" girou para a direita,", :turn}], 0}

      assert response == expected_response
    end

    test "apply GE command, and return a move description" do
      probe_info = {{[], 0}, {" girou para a esquerda,", :turn}}

      response = MovementDescription.call(probe_info)
      expected_response = {[{" girou para a esquerda,", :turn}], 0}

      assert response == expected_response
    end

    test "apply M command, and return a move description" do
      probe_face = "D"
      probe_info = {{[],0}, probe_face}

      response = MovementDescription.call(probe_info)
      expected_response = {[{" moveu 1 casa(s) no eixo x,", :move}], 1}

      assert response == expected_response
    end
  end
end
