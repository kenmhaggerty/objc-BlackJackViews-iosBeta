//
//  FISBlackjackGame.h
//  BlackJack
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISBlackjackPlayer.h"
#import "FISCardDeck.h"

@interface FISBlackjackGame : NSObject
@property (nonatomic, strong) FISCardDeck *deck;
@property (nonatomic, strong) FISBlackjackPlayer *house;
@property (nonatomic, strong) FISBlackjackPlayer *player;
- (void)playBlackjack;
- (void)dealNewRound;
- (void)dealCardToPlayer;
- (void)dealCardToHouse;
- (void)processPlayerTurn;
- (void)processHouseTurn;
- (BOOL)houseWins;
- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins;
@end
