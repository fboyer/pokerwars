defmodule Pokerwars.Hand do
  def score(cards) do
    sorted_cards = Enum.sort(cards, fn c, n -> c.rank <= n.rank end)
    evaluate(sorted_cards)
  end

  defp evaluate(cards) do
    suits = Enum.map(cards, fn card -> card.suit end)
    ranks = Enum.map(cards, fn card -> card.rank end)

    cond do
      same_suit?(suits) && consecutive_ranks?(ranks) ->
        :straight_flush
      x_of_a_kind?(cards, 4) ->
        :four_of_a_kind
      true ->
        :high_card
    end
  end

  def x_of_a_kind?(cards, x) do
    cards
    |> Enum.group_by(fn c -> c.suit end)
    |> Stream.map(fn {suit, cards} -> {suit, Enum.count(cards)} end)
    |> Enum.any?(fn {_suit, n} -> n == x end)
  end

  def same_suit?(suits) do
    first_suit = Enum.fetch!(suits, 0)
    Enum.all?(suits, fn suit -> suit == first_suit end)
  end

  def consecutive_ranks?([cur_rank, next_rank | rem_ranks]) do 
    next_rank - cur_rank == 1 && consecutive_ranks?([next_rank | rem_ranks])
  end
  def consecutive_ranks?(_), do: true
end
