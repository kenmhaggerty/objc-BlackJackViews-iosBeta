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
- (IBAction)deal:(id)sender;
- (IBAction)hit:(id)sender;
- (IBAction)stay:(id)sender;
@end

@implementation FISBlackjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)deal:(id)sender {
    
    //
}

- (IBAction)hit:(id)sender {
    
    //
}

- (IBAction)stay:(id)sender {
    
    //
}

@end
