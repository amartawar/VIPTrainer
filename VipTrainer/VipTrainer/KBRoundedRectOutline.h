//
//  KBRoundedRectOutline.h
//  Peach
//
//  Created by kenney on 1/15/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

//  Creates a transparent view with A colored, rounded rectangle outline.

#import <UIKit/UIKit.h>

@interface KBRoundedRectOutline : UIView
@property (nonatomic) float ringWidth;
@property (nonatomic) float cornerRadius;
@property (nonatomic) UIColor *ringColor;
@property (nonatomic) float roundness;//dont use this one, use cornerRadius
@end
