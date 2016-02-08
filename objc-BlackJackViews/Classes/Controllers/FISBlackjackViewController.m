//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Ken M. Haggerty on 2/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController ()
@property (nonatomic, strong) IBOutlet UILabel *winner;
@property (nonatomic, strong) IBOutlet UILabel *houseScore;
@property (nonatomic, strong) IBOutlet UILabel *houseCard1;
@property (nonatomic, strong) IBOutlet UILabel *houseCard2;
@property (nonatomic, strong) IBOutlet UILabel *houseCard3;
@property (nonatomic, strong) IBOutlet UILabel *houseCard4;
@property (nonatomic, strong) IBOutlet UILabel *houseCard5;
@property (nonatomic, strong) IBOutlet UILabel *houseWins;
@property (nonatomic, strong) IBOutlet UILabel *houseLosses;
@property (nonatomic, strong) IBOutlet UILabel *houseStayed;
@property (nonatomic, strong) IBOutlet UILabel *houseBust;
@property (nonatomic, strong) IBOutlet UILabel *houseBlackjack;
@property (nonatomic, strong) IBOutlet UILabel *playerScore;
@property (nonatomic, strong) IBOutlet UILabel *playerCard1;
@property (nonatomic, strong) IBOutlet UILabel *playerCard2;
@property (nonatomic, strong) IBOutlet UILabel *playerCard3;
@property (nonatomic, strong) IBOutlet UILabel *playerCard4;
@property (nonatomic, strong) IBOutlet UILabel *playerCard5;
@property (nonatomic, strong) IBOutlet UILabel *playerWins;
@property (nonatomic, strong) IBOutlet UILabel *playerLosses;
@property (nonatomic, strong) IBOutlet UILabel *playerStayed;
@property (nonatomic, strong) IBOutlet UILabel *playerBust;
@property (nonatomic, strong) IBOutlet UILabel *playerBlackjack;
@property (nonatomic, strong) IBOutlet UIButton *buttonHit;
@property (nonatomic, strong) IBOutlet UIButton *buttonStay;
@property (nonatomic, strong) NSArray *houseCards;
@property (nonatomic, strong) NSArray *playerCards;
- (IBAction)deal:(id)sender;
- (IBAction)hit:(id)sender;
- (IBAction)stay:(id)sender;
- (IBAction)adjustHue:(UISlider *)sender;
- (void)refreshHouse:(BOOL)visible;
- (void)refreshPlayer;
- (void)housePlays;
- (void)gameOver;
@end

@implementation FISBlackjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setHouseCards:@[self.houseCard1, self.houseCard2, self.houseCard3, self.houseCard4, self.houseCard5]];
    [self setPlayerCards:@[self.playerCard1, self.playerCard2, self.playerCard3, self.playerCard4, self.playerCard5]];
    
    for (UIView *cardView in [self.houseCards arrayByAddingObjectsFromArray:self.playerCards])
    {
        [cardView.layer setCornerRadius:6.0f];
    }
    
    [self.winner setHidden:YES];
    [self refreshHouse:NO];
    [self.houseScore setHidden:YES];
    [self.houseStayed setHidden:YES];
    [self.houseBust setHidden:YES];
    [self.houseBlackjack setHidden:YES];
    [self refreshPlayer];
    [self.playerScore setHidden:YES];
    [self.playerStayed setHidden:YES];
    [self.playerBust setHidden:YES];
    [self.playerBlackjack setHidden:YES];
    [self.buttonHit setEnabled:NO];
    [self.buttonStay setEnabled:NO];
    
    [self setGame:[[FISBlackjackGame alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deal:(id)sender
{
    [self.winner setHidden:YES];
    [self.houseScore setHidden:NO];
    [self.playerScore setHidden:NO];
    
    [self.game.deck resetDeck];
    [self.game.house resetForNewGame];
    [self.game.player resetForNewGame];
    [self.game dealNewRound];
    
    [self refreshPlayer];
    [self refreshHouse:NO];
}

- (IBAction)hit:(id)sender
{
    [self.game dealCardToPlayer];
    [self refreshPlayer];
    if (self.game.player.busted)
    {
        [self gameOver];
        return;
    }
    
    if (self.game.player.cardsInHand.count == 5)
    {
        [self housePlays];
    }
}

- (IBAction)stay:(id)sender
{
    [self.game.player setStayed:YES];
    [self refreshPlayer];
    [self housePlays];
}

- (IBAction)adjustHue:(UISlider *)sender
{
    UIColor *color = [UIColor colorWithHue:sender.value saturation:1.0f brightness:1.0f alpha:1.0f];
    for (UIView *cardView in [self.houseCards arrayByAddingObjectsFromArray:self.playerCards])
    {
        [cardView setBackgroundColor:color];
    }
    [sender setTintColor:color];
}

- (void)refreshHouse:(BOOL)visible
{
    UILabel *cardLabel;
    FISCard *card;
    for (NSUInteger i = 0; i < self.houseCards.count; i++)
    {
        cardLabel = [self.houseCards objectAtIndex:i];
        if (i >= self.game.house.cardsInHand.count)
        {
            [cardLabel setText:nil];
            [cardLabel setHidden:YES];
            continue;
        }
        
        if (!visible && (i == 0))
        {
            [cardLabel setText:@"❂"];
        }
        else
        {
            card = [self.game.house.cardsInHand objectAtIndex:i];
            [cardLabel setText:[card cardLabel]];
        }
        [cardLabel setHidden:NO];
    }
    [self.houseScore setHidden:!visible];
    [self.houseScore setText:[NSString stringWithFormat:@"Score: %lu", self.game.house.handscore]];
    [self.houseBlackjack setHidden:(!self.game.house.blackjack || !visible)];
    [self.houseBust setHidden:(!self.game.house.busted || !visible)];
    [self.houseStayed setHidden:(!self.game.house.stayed || !visible)];
}

- (void)refreshPlayer
{
    UILabel *cardLabel;
    FISCard *card;
    for (NSUInteger i = 0; i < self.playerCards.count; i++)
    {
        cardLabel = [self.playerCards objectAtIndex:i];
        if (i >= self.game.player.cardsInHand.count)
        {
            [cardLabel setText:nil];
            [cardLabel setHidden:YES];
            continue;
        }
        
        card = [self.game.player.cardsInHand objectAtIndex:i];
        [cardLabel setText:[card cardLabel]];
        [cardLabel setHidden:NO];
    }
    [self.playerScore setText:[NSString stringWithFormat:@"Score: %lu", self.game.player.handscore]];
    [self.playerBlackjack setHidden:!self.game.player.blackjack];
    [self.playerBust setHidden:!self.game.player.busted];
    [self.playerStayed setHidden:!self.game.player.stayed];
    [self.buttonHit setEnabled:!self.game.player.busted];
    [self.buttonStay setEnabled:!self.game.player.busted];
}

- (void)housePlays
{
    while (!self.game.house.busted && !self.game.house.stayed && (self.game.house.cardsInHand.count <= self.houseCards.count)) {
        [self.game processHouseTurn];
        [self refreshHouse:YES];
    }
    [self gameOver];
}

- (void)gameOver
{
    [self.buttonHit setEnabled:NO];
    [self.buttonStay setEnabled:NO];
    [self.game incrementWinsAndLossesForHouseWins:self.game.houseWins];
    [self.winner setHidden:NO];
    [self.winner setText:self.game.houseWins ? @"You lost!" : @"You won!"];
    [self.houseWins setText:[NSString stringWithFormat:@"Wins: %lu", self.game.house.wins]];
    [self.houseLosses setText:[NSString stringWithFormat:@"Losses: %lu", self.game.house.losses]];
    [self.playerWins setText:[NSString stringWithFormat:@"Wins: %lu", self.game.player.wins]];
    [self.playerLosses setText:[NSString stringWithFormat:@"Losses: %lu", self.game.player.losses]];
}

@end
