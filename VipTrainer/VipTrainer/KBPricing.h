//
//  KBPricing.h
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBPricing : KBViewController
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *hourlyRateField;
@property (weak, nonatomic) IBOutlet UITextField *paypalEmailField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end
