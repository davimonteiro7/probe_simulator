defmodule ProbeSimulator.Probes.MovementDescription do

  def call(probe_info) do
    mount_description(probe_info)
  end

  defp get_axis(face) when face == "E" or face == "D" do
    "x"
  end
  defp get_axis(face) when face == "C" or face == "B" do
    "y"
  end

  defp mount_description({{current_description, _}, description = {_, :turn}}) do
    {current_description ++ [description], 0}
  end
  defp mount_description({{current_description, num_of_movements}, face}) do

    write_description(current_description, num_of_movements, get_axis(face))
  end

  defp write_description([], num_of_movements, axis) do
    write_with_direction([], axis, num_of_movements)
  end
  defp write_description(current_description, num_of_movements, axis) do
    last_snippet = List.last(current_description)
    case last_snippet do
      {_, :turn} -> write_with_direction(current_description, axis, num_of_movements)
      {_, :move} ->
        new_list = List.delete(current_description, last_snippet)
        write_with_direction(new_list, axis, num_of_movements)
    end
  end
  defp write_with_direction(current_description, axis, num_of_movements) do
    {current_description ++ [{" moveu #{num_of_movements + 1} casa(s) no eixo #{axis},", :move}], num_of_movements + 1}
  end
end
