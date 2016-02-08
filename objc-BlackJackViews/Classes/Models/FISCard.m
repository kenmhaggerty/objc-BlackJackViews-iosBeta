//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard ()
@property (nonatomic, strong, readwrite) NSString *suit;
@property (nonatomic, strong, readwrite) NSString *rank;
@property (nonatomic, strong, readwrite) NSString *cardLabel;
@property (nonatomic, readwrite) NSUInteger cardValue;
@end

@implementation FISCard

+ (NSArray *)validSuits {
    
    return @[@"♠", @"♥", @"♣", @"♦"];
}

+ (NSArray *)validRanks {
    
    return @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (instancetype)init {
    
    self = [self initWithSuit:@"!" rank:@"N"];
    return self;
}

- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank {
    
    self = [super init];
    if (self) {
        _suit = suit;
        _rank = rank;
        _cardLabel = [FISCard cardLabelForSuit:suit rank:rank];
        _cardValue = [FISCard cardValueForRank:rank];
    }
    return self;
}

- (NSString *)description {
    
    return self.cardLabel;
}

+ (NSString *)cardLabelForSuit:(NSString *)suit rank:(NSString *)rank {
    
    return [NSString stringWithFormat:@"%@%@", suit, rank];
}

+ (NSUInteger)cardValueForRank:(NSString *)rank {
    
    return MIN([[FISCard validRanks] indexOfObject:rank]+1, 10);
}

@end
