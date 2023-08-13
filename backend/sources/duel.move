module duel::game {
    use aptos_framework::timestamp;
    use std::string::{Self, String};
    use aptos_framework::coin::{Self, Coin, BurnCapability, FreezeCapability, MintCapability};

    use std::signer;

    struct CARD has key, copy, store, drop {
        power: u64,
        multiplier: u64,
        name: String,
        description: String,
    }
    struct Duel has key, store {
        // the player who initiated the duel
        player: address,
        // the player who accepted the duel
        opponent: address,
        // the amount of coins wagered by the player
        wager: Coin<DuelToken>,
        // the player's card
        player_card: CARD,
    }
    struct DuelToken {}

    struct Capabilities has key {
        burn_capability: BurnCapability<DuelToken>,
        freeze_capability: FreezeCapability<DuelToken>,
        mint_capability: MintCapability<DuelToken>,
    }

    const ERR_UNAUTHORIZED: u64 = 0;
    const ERR_INCORRECT_OPPONENT: u64 = 1;
    const ERR_INSUFFICIENT_FUNDS: u64 = 2;

    public entry fun initialize(deployer: &signer) {
        assert!(signer::address_of(deployer) == @duel, ERR_UNAUTHORIZED);
        
        let name = string::utf8(b"Dank Duel Token");
        let symbol = string::utf8(b"DD");
        let decimals = 8;

        let (burn_capability, freeze_capability, mint_capability) =
            coin::initialize<DuelToken>(deployer, name, symbol, decimals, false);

        move_to(deployer, Capabilities { burn_capability, freeze_capability, mint_capability });
    }

    // Users can name and create their own cards!
    public entry fun mint_card(player: &signer, name: String, description: String) {
        let random_power = timestamp::now_microseconds() % 10;
        let random_multiplier = 1;
        move_to(player, CARD {
            power: random_power,
            multiplier: random_multiplier,
            name,
            description,
        })
    }

    // 
    public entry fun play_duel(player1: &signer, player2: address, wager: u64) acquires CARD{
        assert!(signer::address_of(player1) != player2, ERR_UNAUTHORIZED);
        assert!(coin::balance<DuelToken>(signer::address_of(player1)) >= wager, ERR_INSUFFICIENT_FUNDS);
        let player1_card_ref = borrow_global<CARD>(signer::address_of(player1));
        let player1_card = *player1_card_ref;
        let player2_card_ref = borrow_global<CARD>(player2);
        let player2_card = *player2_card_ref;
        assert!(player1_card.power != 0, ERR_UNAUTHORIZED);
        assert!(player2_card.power != 0, ERR_UNAUTHORIZED);
        let player1_net_power = player1_card.power * player1_card.multiplier;
        let player2_net_power = player2_card.power * player2_card.multiplier;
        let random_number = timestamp::now_microseconds() % (player1_net_power + player2_net_power);
        if (random_number <= player1_net_power) {
            if (player1_card.power < player2_card.power) {
                let temp = player2_card.power;
                player2_card.power = player1_card.power;
                player1_card.power = temp + player1_card.power;
                player1_card.multiplier = player1_card.multiplier + 1;
            }
            else {
                player1_card.power = player1_card.power + player2_card.power;
            }
        } else {
                if (player1_card.power > player2_card.power) {
                let temp = player1_card.power;
                player1_card.power = player2_card.power;
                player2_card.power = temp + player2_card.power;
                player2_card.multiplier = player2_card.multiplier + 1;
            }
            else {
                player2_card.power = player1_card.power + player2_card.power;
            }
        };

        move_to(player1, Duel {
            player: signer::address_of(player1),
            opponent: player2,
            wager: coin::withdraw<DuelToken>(player1, wager),
            player_card: player1_card,
        })
    }

    // Mint duel tokens to wager in games!
    public entry fun mint_token(player: &signer, amount: u64) acquires Capabilities {
        let cap = borrow_global<Capabilities>(@duel);

        if (!coin::is_account_registered<DuelToken>(signer::address_of(player))){
            coin::register<DuelToken>(player);
        };

        let coins = coin::mint<DuelToken>(amount, &cap.mint_capability);
        coin::deposit<DuelToken>(signer::address_of(player), coins);
    }

}