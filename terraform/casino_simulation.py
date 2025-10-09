import random

def casino_simulation(player_budget=270000, casino_capital=8500000, base_bet=5, max_rounds=1000000):
    """
    Simulates a casino game using the Martingale betting strategy.

    Parameters:
    - player_budget: Initial budget of the player (int).
    - casino_capital: Initial capital of the casino (int).
    - base_bet: Starting bet amount (int).
    - max_rounds: Maximum number of rounds to simulate to prevent infinite loops (int).

    The game involves betting on a random number from 1 to 100 being less than 50.
    Probability of winning is approximately 49% (numbers 1-49).
    On win: Player receives double the bet (original bet returned plus equal win).
    On loss: Player loses the bet.

    Strategy: Martingale - Double the bet after each loss, reset to base_bet after a win.

    Returns statistics after simulation ends (player bankrupt, casino bankrupt, or max rounds reached).
    """

    current_bet = base_bet
    rounds_played = 0
    wins = 0
    losses = 0
    initial_player_budget = player_budget

    while player_budget > 0 and casino_capital > 0 and rounds_played < max_rounds:
        if current_bet > player_budget:
            # Player cannot afford the next bet; simulation ends.
            break

        # Place the bet
        player_budget -= current_bet
        casino_capital += current_bet

        # Generate random number
        random_number = random.randint(1, 100)

        if random_number < 50:
            # Win: Receive double the bet
            payout = current_bet * 2
            if payout > casino_capital:
                # Casino cannot pay; player gets remaining casino capital
                payout = casino_capital
                casino_capital = 0
            else:
                casino_capital -= payout
            player_budget += payout
            wins += 1
            # Reset bet after win
            current_bet = base_bet
        else:
            # Loss: Bet is already deducted
            losses += 1
            # Double bet for next round
            current_bet *= 2

        rounds_played += 1

    # Prepare statistics
    stats = {
        "Rounds Played": rounds_played,
        "Wins": wins,
        "Losses": losses,
        "Final Player Budget": player_budget,
        "Initial Player Budget": initial_player_budget,
        "Net Player Change": player_budget - initial_player_budget,
        "Final Casino Capital": casino_capital,
        "Simulation End Reason": (
            "Player Bankrupt" if player_budget <= 0 else
            "Casino Bankrupt" if casino_capital <= 0 else
            "Max Rounds Reached" if rounds_played >= max_rounds else
            "Bet Exceeded Budget"
        )
    }

    # Print statistics
    print("Casino Simulation Statistics:")
    for key, value in stats.items():
        print(f"{key}: {value}")

    return stats

# Run the simulation with default parameters
casino_simulation()
