//
//  KBInterestsList.h
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KBInterestsDelegate <NSObject>
-(void)KBInterestsList:(id)list didSelectInterest:(NSString *)interest;
-(void)KBInterestsList:(id)list didSelectInterests:(NSArray *)interests;
-(void)KBInterestsListDidCancel:(id)list;
-(BOOL)KBInterestsListShouldAllowCancel;
-(void)KBInterestsListSave;
@end

@interface KBInterestsList : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
- (IBAction)next:(id)sender;
@property (nonatomic, weak) id<KBInterestsDelegate> delegate;

@end
