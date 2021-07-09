defmodule ProbeSimulatorWeb.ProbeController do
  use ProbeSimulatorWeb, :controller

  alias ProbeSimulator.Probes.{SendProbe, GetProbe, MoveProbe}

  def send_probe(conn, _params) do
    SendProbe.call()
    |> handle_response(conn)
  end

  def show_probe(conn, _params) do
    GetProbe.call()
    |> handle_response(conn)
  end

  def move_probe(conn, params) do
    params
      |> MoveProbe.call
      |> handle_response(conn)
  end

  defp handle_response({status, result}, conn) do
    conn
    |> put_status(status)
    |> json(result)
  end
end
