module duel::game {
    // use aptos_framework::timestamp;
    use std::string::{Self, String};
    use aptos_framework::coin::{Self, Coin, BurnCapability, FreezeCapability, MintCapability, CoinInfo};
    // use 0x1::Random;
    use std::debug::print;
    use std::signer;
    // use 0x1::Debug;

    // COMMENTED OUT FOR NOW


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
        // let random_power = timestamp::now_microseconds() % 10;
        let random_power = 1;
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
        // assert!(player1_card.power != player2_card.power, ERR_UNAUTHORIZED);
        let player1_net_power = player1_card.power * player1_card.multiplier;
        // let player2_net_power = player2_card.power * player2_card.multiplier;
        // let random_number = timestamp::now_microseconds() % (player1_net_power + player2_net_power);
        let random_number = 5;
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

        // Define a test function
    #[test(player = @0x1)]
    public fun test_move_to_player(player: &signer) acquires CARD{
        // Create a new account to represent the player
        // let player = Testing::create_account(1000);

        // Move the CARD resource to the player account
        move_to(player, CARD {
            power: 10,
            multiplier: 2,
            name: string::utf8(b"Test Card"),
            description: string::utf8(b"This is a test card"),
        });

        // Borrow a reference to the CARD resource for the player account
        let player_card_ref = borrow_global<CARD>(signer::address_of(player));

        // Assert that the CARD resource was moved correctly
        assert!(player_card_ref.power == 10, 1);
        assert!(player_card_ref.multiplier == 2, 2);
        assert!(player_card_ref.name == string::utf8(b"Test Card"), 3);
        assert!(player_card_ref.description == string::utf8(b"This is a test card"), 4);
    }

    #[test(player = @0x101, opponent = @0x2, dank = @0xf95cbc900b2f4bf53d915054218e6f7179e75c4426f93c4b7739600cda128096)]
    public fun test_play_duel(player: &signer, opponent: &signer, dank: &signer) acquires CARD
    , Capabilities 
    {
    // Mint a new card for the player
    duel::game::initialize(dank);
    let player_card_name = string::utf8(b"Player's Card");
    let player_card_description = string::utf8(b"This is the player's card");
    duel::game::mint_card(player, player_card_name, player_card_description);
    let player_card_ref = borrow_global<CARD>(signer::address_of(player));
    let player_card = *player_card_ref;
    player_card.power = 10;
    // let player_card_power = player_card.power;

    // Mint a new card for the opponent
    let opponent_card_name = string::utf8(b"Opponent's Card");
    let opponent_card_description = string::utf8(b"This is the opponent's card");
    duel::game::mint_card(opponent, opponent_card_name, opponent_card_description);
    let opponent_card_ref = borrow_global<CARD>(signer::address_of(opponent));
    let opponent_card = *opponent_card_ref;
    opponent_card.power = 5;
    // // let opponent_card_power = opponent_card.power;

    // Mint some tokens for the player
    let wager_amount = 100;
    print(&CoinInfo::name<DuelToken>());
    duel::game::mint_token(player, wager_amount);

    // Play a duel between the player and the opponent
    // duel::game::play_duel(player, signer::address_of(opponent), 0);

    assert!(player_card.power + opponent_card.power == 15, 1);
}
}