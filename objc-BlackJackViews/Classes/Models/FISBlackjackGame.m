//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _deck = [[FISCardDeck alloc] init];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
    }
    return self;
}

- (void)playBlackjack {
    
    [self.deck resetDeck];
    [self.house resetForNewGame];
    [self.player resetForNewGame];
    [self dealNewRound];
    int i = 0;
    while (i < 3) {
        [self processPlayerTurn];
        if (self.player.busted) break;
        [self processHouseTurn];
        if (self.house.busted) break;
        i++;
    }
    [self incrementWinsAndLossesForHouseWins:[self houseWins]];
    NSLog(@"%@", self.player.description);
    NSLog(@"%@", self.house.description);
}

- (void)dealNewRound {
    
    for (int i = 0; i < 2; i++) {
        [self dealCardToPlayer];
        [self dealCardToHouse];
    }
}

- (void)dealCardToPlayer {
    
    [self.player acceptCard:[self.deck drawNextCard]];
}

- (void)dealCardToHouse {
    
    [self.house acceptCard:[self.deck drawNextCard]];
}

- (void)processPlayerTurn {
    
    if (self.player.stayed || ![self.player shouldHit] || self.player.busted) return;
    
    [self dealCardToPlayer];
}

- (void)processHouseTurn {
    
    if (self.house.stayed || ![self.house shouldHit] || self.house.busted) return;
    
    [self dealCardToHouse];
}

- (BOOL)houseWins {
    
    if (self.house.busted) return NO;
    
    if (self.player.busted) return YES;
    
    if (self.house.blackjack && self.player.blackjack) return NO;
    
    return (self.house.handscore >= self.player.handscore);
}

- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    
    NSLog(@"The house %@!", houseWins ? @"won" : @"lost");
    self.house.wins += houseWins;
    self.player.losses += houseWins;
    self.house.losses += houseWins ? 0 : 1;
    self.player.wins += houseWins ? 0 : 1;
    NSLog(@"house = %lu wins, %lu losses", self.house.wins, self.house.losses);
    NSLog(@"player = %lu wins, %lu losses", self.player.wins, self.player.losses);
}

@end
