//
//  FISCardDeck.h
//  OOP-Cards-Model
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISCard.h"

@interface FISCardDeck : NSObject
@property (nonatomic, strong) NSMutableArray *remainingCards;
@property (nonatomic, strong) NSMutableArray *dealtCards;
- (FISCard *)drawNextCard;
- (void)resetDeck;
- (void)gatherDealtCards;
- (void)shuffleRemainingCards;
@end
