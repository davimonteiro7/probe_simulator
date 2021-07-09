defmodule ProbeSimulator.Probes.MoveProbeTest do
  use ExUnit.Case

  alias ProbeSimulator.Probes.MoveProbe
  alias ProbeSimulator.Probes.SendProbe
  alias ProbeSimulator.Probes.ProbeRepository

  @moviments %{"movimentos" => ["GE", "M", "M", "M", "GD", "M", "M", "M"]}

  describe "call/1" do
    test " send a valid movement commands to an existent probe." do
      SendProbe.call()

      response = MoveProbe.call(@moviments)
      expected_response = {:ok, %{description: "a sonda girou para a esquerda, moveu 3 casa(s) no eixo y, girou para a direita, moveu 3 casa(s) no eixo x,", probe: %{x: 3, y: 3}}}

      assert response == expected_response

      ProbeRepository.delete()
    end

    test " send an invalid movement commands to an existent probe." do
      SendProbe.call()
      MoveProbe.call(@moviments)

      response = MoveProbe.call(@moviments)
      expected_response = {:bad_request, %{erro: "Um movemento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de se mover fora dos limites configurados (Quadrante 5x5)."}}


      assert response == expected_response

      ProbeRepository.delete()
    end

    test " send a movement commands to a nonexistent probe." do

      response = MoveProbe.call(@moviments)
      expected_response = {:bad_request, %{message: "Probe not found, please create on (/api/probe_simulator/create_probe) first."}}

      assert response == expected_response

      ProbeRepository.delete()
    end
  end
end
