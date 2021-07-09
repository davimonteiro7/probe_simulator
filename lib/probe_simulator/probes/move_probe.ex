defmodule ProbeSimulator.Probes.MoveProbe do

  alias ProbeSimulator.Probes.ProbeRepository
  alias ProbeSimulator.Probes.MovementDescription

  def call(movements) do

    case ProbeRepository.get() do
      {:error, _} -> {:bad_request, %{message: "Probe not found, please create on (/api/probe_simulator/create_probe) first."}}
      {_, probe,} ->
        movements
          |> handle_movement(probe)
          |> validate_movement
    end
  end

  defp handle_movement(movements, probe) do
    tracked_probe = track_the_probe(probe)
    commands = extract_commands(movements)

    {moved_probe, {description, _}} = parse_commands(commands, tracked_probe)
    text_description = get_text_description(description)

    {moved_probe, text_description}
  end

  defp validate_movement({moved_probe, text_description})
    when (moved_probe.x in 0..4) and (moved_probe.y in 0..4) do
      ProbeRepository.delete()

      case ProbeRepository.insert(moved_probe) do
        {:erro, reason} -> {:bad_request, %{message: reason}}
        _   -> {:ok, %{ probe: %{x: moved_probe.x, y: moved_probe.y}, description: text_description}}
      end
  end
  defp validate_movement(_moved_probe), do: {:bad_request , %{erro: "Um movemento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de se mover fora dos limites configurados (Quadrante 5x5)."}}

  defp track_the_probe(probe) do
    current_description = []
    num_of_movements = 0
    { probe, {current_description, num_of_movements}}
  end

  defp extract_commands(movements) do
    movements
      |> Map.values()
      |> Enum.at(0)
  end

  defp parse_commands([], tracked_probe), do: tracked_probe
  defp parse_commands([command | tail_commands], current_tracked_probe) do
    tracked_probe = apply_command(command, current_tracked_probe)
    parse_commands(tail_commands, tracked_probe)
  end

  defp get_text_description(description) do
    description
      |> Enum.map(fn {text, _} -> text end )
      |> List.insert_at(0, "a sonda")
      |> Enum.join()
  end

  defp apply_command("GE", tracked_probe) do
    {probe, movement_description} = tracked_probe
    probe_info = {movement_description, {" girou para a esquerda,", :turn}}
    description = MovementDescription.call(probe_info)

    case probe.face do
      "E" -> { %{x: probe.x, y: probe.y, face: "B"}, description }
      "D" -> { %{x: probe.x, y: probe.y, face: "C"}, description }
      "C" -> { %{x: probe.x, y: probe.y, face: "E"}, description }
      "B" -> { %{x: probe.x, y: probe.y, face: "D"}, description }
    end
  end
  defp apply_command("GD", tracked_probe) do
    {probe, movement_description} = tracked_probe

    probe_info = {movement_description, {" girou para a direita,", :turn}}
    description = MovementDescription.call(probe_info)

    case probe.face do
      "E" -> { %{x: probe.x, y: probe.y, face: "C"}, description }
      "D" -> { %{x: probe.x, y: probe.y, face: "B"}, description }
      "C" -> { %{x: probe.x, y: probe.y, face: "D"}, description }
      "B" -> { %{x: probe.x, y: probe.y, face: "E"}, description }
    end
  end
  defp apply_command("M", tracked_probe) do
    {probe, movement_description} = tracked_probe

    probe_info = {movement_description, probe.face}
    description = MovementDescription.call(probe_info)

    case probe.face do
      "E" -> { %{x: probe.x - 1, y: probe.y, face: probe.face}, description }
      "D" -> { %{x: probe.x + 1, y: probe.y, face: probe.face}, description }
      "C" -> { %{x: probe.x, y: probe.y + 1, face: probe.face}, description }
      "B" -> { %{x: probe.x, y: probe.y - 1, face: probe.face}, description }
    end
  end
end
