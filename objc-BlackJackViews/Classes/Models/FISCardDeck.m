//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@implementation FISCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        _remainingCards = [NSMutableArray array];
        _dealtCards = [NSMutableArray array];
        [self generateDeck];
    }
    return self;
}

- (FISCard *)drawNextCard {
    
    if (!self.remainingCards.count) {
        NSLog(@"deck is empty");
        return nil;
    }
    
    FISCard *card = [self.remainingCards firstObject];
    [self.remainingCards removeObject:card];
    [self.dealtCards addObject:card];
    return card;
}

- (void)resetDeck {
    
    [self gatherDealtCards];
    [self shuffleRemainingCards];
}

- (void)gatherDealtCards {
    
    [self.remainingCards addObjectsFromArray:self.dealtCards];
    [self.dealtCards removeAllObjects];
}

- (void)shuffleRemainingCards {
    
    NSMutableArray *copiedDeck = [self.remainingCards mutableCopy];
    [self.remainingCards removeAllObjects];
    FISCard *card;
    while (copiedDeck.count) {
        card = [copiedDeck objectAtIndex:arc4random_uniform((unsigned int)copiedDeck.count)];
        [copiedDeck removeObject:card];
        [self.remainingCards addObject:card];
    }
}

- (void)generateDeck {
    
    for (NSString *suit in [FISCard validSuits]) {
        for (NSString *rank in [FISCard validRanks]) {
            [self.remainingCards addObject:[[FISCard alloc] initWithSuit:suit rank:rank]];
        }
    }
}

- (NSString *)description {
    NSMutableArray *cardDescriptions = [NSMutableArray arrayWithCapacity:self.remainingCards.count];
    for (NSUInteger i = 0; i < self.remainingCards.count; i++) {
        [cardDescriptions addObject:((FISCard *)[self.remainingCards objectAtIndex:i]).description];
    }
    return [NSString stringWithFormat:@"count: %lu\ncards: %@", (unsigned long)self.remainingCards.count, [cardDescriptions componentsJoinedByString:@" "]];
}

@end
