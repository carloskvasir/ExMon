defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @heal_power 18..25

  def heal_life(player) do
    heal = calculate_heal()

    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_new_life(heal)
    |> set_life(player, heal)
  end

  defp calculate_heal(), do: Enum.random(@heal_power)

  defp calculate_new_life(life, heal) when life + heal > 100, do: 100
  defp calculate_new_life(life, heal), do: life + heal

  defp set_life(life, player, heal) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(player, heal)
  end

  defp update_game(player_data, player, heal) do
    Game.info()
    |> Map.put(player, player_data)
    |> Game.update()

    Status.print_move_message(player, :heal, heal)
  end
end
