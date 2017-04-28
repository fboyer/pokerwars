defmodule Pokerwars.HandTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  describe "score/1" do
    @tag :skip
    test "evaluates royal flush of hearts" do
      cards = [
        %Card{rank: 10, suit: :hearts},
        %Card{rank: 11, suit: :hearts},
        %Card{rank: 12, suit: :hearts},
        %Card{rank: 13, suit: :hearts},
        %Card{rank: 14, suit: :hearts}
      ]

      assert Hand.score(cards) == :royal_flush
    end

    @tag :skip
    test "evaluates royal flush of spades" do
      cards = [
        %Card{rank: 10, suit: :spades},
        %Card{rank: 11, suit: :spades},
        %Card{rank: 12, suit: :spades},
        %Card{rank: 13, suit: :spades},
        %Card{rank: 14, suit: :spades}
      ]

      assert Hand.score(cards) == :royal_flush
    end

    test "does not evaluate royal flush for mismatching suits" do
      cards = [
        %Card{rank: 10, suit: :diamonds},
        %Card{rank: 11, suit: :diamonds},
        %Card{rank: 12, suit: :diamonds},
        %Card{rank: 13, suit: :clubs},
        %Card{rank: 14, suit: :clubs}
      ]

      assert Hand.score(cards) != :royal_flush
    end

    test "evaluates straight flush of clubs" do
      cards = [
        %Card{rank: 7, suit: :clubs},
        %Card{rank: 8, suit: :clubs},
        %Card{rank: 9, suit: :clubs},
        %Card{rank: 10, suit: :clubs},
        %Card{rank: 11, suit: :clubs}
      ]

      assert Hand.score(cards) == :straight_flush
    end

    test "does not evaluate straight flush for non consecutive values" do
      cards = [
        %Card{rank: 7, suit: :clubs},
        %Card{rank: 8, suit: :clubs},
        %Card{rank: 9, suit: :clubs},
        %Card{rank: 10, suit: :clubs},
        %Card{rank: 2, suit: :clubs}
      ]

      refute Hand.score(cards) == :straight_flush
    end

    test "does not evaluate straight flush for mismatching suits" do
      cards = [
        %Card{rank: 7, suit: :clubs},
        %Card{rank: 8, suit: :clubs},
        %Card{rank: 9, suit: :spades},
        %Card{rank: 10, suit: :clubs},
        %Card{rank: 11, suit: :clubs}
      ]

      refute Hand.score(cards) == :straight_flush
    end

    test "evaluates to four of a kind" do
      cards = [
        %Card{rank: 7, suit: :clubs},
        %Card{rank: 8, suit: :clubs},
        %Card{rank: 9, suit: :spades},
        %Card{rank: 10, suit: :clubs},
        %Card{rank: 11, suit: :clubs}
      ]

      assert Hand.score(cards) == :four_of_a_kind
    end
    
    test "does not evaluate to four of a kind for mismatching suits" do
      cards = [
        %Card{rank: 7, suit: :hearts},
        %Card{rank: 8, suit: :clubs},
        %Card{rank: 9, suit: :spades},
        %Card{rank: 10, suit: :diamonds},
        %Card{rank: 11, suit: :clubs}
      ]

      refute Hand.score(cards) == :four_of_a_kind
    end

    test "evaluates high card" do
      cards = [
        %Card{rank: 2, suit: :spades},
        %Card{rank: 3, suit: :hearts},
        %Card{rank: 5, suit: :diamonds},
        %Card{rank: 7, suit: :spades},
        %Card{rank: 11, suit: :spades}
      ]

      assert Hand.score(cards) == :high_card
    end
  end

  describe "same suit?/1" do
    test "returns true when all suits are the same" do
      suits = [
        :hearts,
        :hearts,
        :hearts,
        :hearts,
        :hearts
      ]

      assert Hand.same_suit?(suits)
    end

    test "returns false when suits are not the same" do
      suits = [
        :hearts,
        :hearts,
        :hearts,
        :hearts,
        :diamonds
      ]

      refute Hand.same_suit?(suits)
    end
  end

  describe "consecutive_ranks?/1" do
    test "returns true when ranks are consecutive" do
      ranks = [1, 2, 3, 4, 5]
      
      assert Hand.consecutive_ranks?(ranks)
    end

    test "returns false when ranks are not consecutive" do
      ranks = [1, 2, 3, 5, 6]

      refute Hand.consecutive_ranks?(ranks)
    end
  end
end
