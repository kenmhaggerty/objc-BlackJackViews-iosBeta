//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer

- (instancetype)init {
    
    self = [self initWithName:@""];
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    if (self) {
        _name = name;
        _cardsInHand = [NSMutableArray array];
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
    }
    return self;
}

- (void)resetForNewGame {
    
    [self.cardsInHand removeAllObjects];
    [self setHandscore:0];
    [self setAceInHand:NO];
    [self setBlackjack:NO];
    [self setBusted:NO];
    [self setStayed:NO];
}

- (void)acceptCard:(FISCard *)card {
    
    [self.cardsInHand addObject:card];
    self.handscore = 0;
    for (FISCard *cardInHand in self.cardsInHand) {
        self.handscore += MIN(cardInHand.cardValue, 10);
    }
    if ([card.rank isEqualToString:@"A"]) self.aceInHand = YES;
    if (self.aceInHand && (self.handscore <= 11)) {
        self.handscore += 10;
    }
    if (self.handscore > 21) {
        self.busted = YES;
    }
    else if ((self.handscore == 21) && (self.cardsInHand.count == 2)) {
        self.blackjack = YES;
    }
}

- (BOOL)shouldHit {
    
    self.stayed = (self.handscore > 16);
    return !self.stayed;
}

- (NSString *)description {
    
    NSMutableArray *cardsInHand = [NSMutableArray arrayWithCapacity:self.cardsInHand.count];
    for (FISCard *card in self.cardsInHand) {
        [cardsInHand addObject:card.description];
    }
    return [NSString stringWithFormat:@"%@:\nname: %@\ncards: %@\nhandscore: %lu\nace in hand: %d\nstayed: %d\nblackjack: %d\nbusted: %d\nwins: %lu\nlosses: %lu", NSStringFromClass([self class]), self.name, [cardsInHand componentsJoinedByString:@" "], (unsigned long)self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
}

@end
