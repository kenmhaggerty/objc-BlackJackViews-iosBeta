//
//  FISCard.h
//  OOP-Cards-Model
//
//  Created by Ken M. Haggerty on 2/1/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISCard : NSObject
@property (nonatomic, strong, readonly) NSString *suit;
@property (nonatomic, strong, readonly) NSString *rank;
@property (nonatomic, strong, readonly) NSString *cardLabel;
@property (nonatomic, readonly) NSUInteger cardValue;
+ (NSArray *)validSuits;
+ (NSArray *)validRanks;
- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;
@end
