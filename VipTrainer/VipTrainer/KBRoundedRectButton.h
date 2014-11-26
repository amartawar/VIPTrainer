//
//  RoundedRectButton.h
//  VendevorIpad
//
//  Created by kyle barnes on 5/22/13.
//  Copyright (c) 2013 Kyle Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"

@interface KBRoundedRectButton : UIButton

@property (nonatomic, strong) UIColor *Background_Color;
@property (nonatomic, strong) UIColor *Highlighted_Color;
@property (nonatomic, strong) UIColor *Disabled_Color;
@property (nonatomic) BOOL topLeftRounded;
@property (nonatomic) BOOL topRightRounded;
@property (nonatomic) BOOL bottomLeftRounded;
@property (nonatomic) BOOL bottomRightRounded;
@property (nonatomic) Colors color;
@property (nonatomic) float backgroundAlpha;

-(void)setTop;
-(void)setBottom;
-(void)setAll;
@end
