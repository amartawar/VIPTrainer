//
//  KBInterestsList.m
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBInterestsList.h"
#import "KBInterestsRowCell.h"
#import "KBSplitViewController.h"

@implementation KBInterestsList{
    NSArray *interests;
}
@synthesize delegate;


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        interests = @[@"Overall Health", @"Muscle Mass", @"Cardio", @"General Upkeep", @"Weight Loss"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([User currentUser])
        self.nextButton.title = @"Save";
    else if(IS_TRAINER)
        self.nextButton.title = @"Done";
    else
        self.nextButton.title = @"Next";
    
    for(NSString *str1 in DATA.user.interests){
        for(int i = 0; i < interests.count; i++){
            if([interests[i] isEqualToString:str1]){
                [self.table selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(KBInterestsList:didSelectInterest:)]){
        [self.delegate KBInterestsList:self didSelectInterest:interests[indexPath.row]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return interests.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *interestsRowCellIdentifier = @"interestsRowCell";
    
    
    KBInterestsRowCell *cell = [tableView dequeueReusableCellWithIdentifier:interestsRowCellIdentifier];
    if(!cell){
        cell = [[KBInterestsRowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:interestsRowCellIdentifier];
    }
    [cell layoutIfNeeded];
    
    cell.text.text = interests[indexPath.row];
    
    return cell;
}

- (IBAction)next:(id)sender {
    
    NSMutableArray *interestsArray = [[NSMutableArray alloc] init];
    NSArray *indexPaths = [self.table indexPathsForSelectedRows];
    
    
    
    for(NSIndexPath *ip in indexPaths){
        [interestsArray addObject:interests[ip.row]];
    }
    
    DATA.user.interests = interestsArray;
    
    
    if([User currentUser]){
        [self showProgress:@"Saving"];
        [DATA.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            if(!error){
                DATA.user = [User currentUser];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                
            }
        }];
    }
    else{
        
        
        //Copys DATA.user info into a new User object. Otherwise parse throws stupid errors
        User *newUser = [User object];
        
        for(NSString *key in DATA.user.allKeys){
            DebugLog(@"KEY:%@",key);
            [newUser setObject:[DATA.user objectForKey:key] forKey:key];
        }
        
        newUser.password = DATA.user.password;
        
        [self showProgress:@"Creating Account"];
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            if (!error) {
                if([self.delegate respondsToSelector:@selector(KBInterestsListSave)]){
                    [self.delegate KBInterestsListSave];
                }
                return;
                
            } else {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                [self showMessage:errorString];
                [User logOut];
                return;
            }
        }];
    }
}

@end
