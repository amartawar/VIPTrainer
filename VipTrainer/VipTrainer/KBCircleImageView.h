//
//  KBCircleImageView.h
//  Peach
//
//  Created by kenney on 1/9/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//


/*
    This is for showing circular images. This is a container with a PFImageView subview, that clips it in a circle.
 */

#import <UIKit/UIKit.h>

@interface KBCircleImageView : UIImageView
@property (nonatomic) PFImageView *imageView;
@property (nonatomic) PFFile *file;
- (void)loadInBackground;


//Properties for use in Interface Builder, so we dont have to set these in code
@property (nonatomic) BOOL showRing; //Ring border around image
@property (nonatomic) float ringWidth;
@property (nonatomic) UIColor *ringColor;
@property (nonatomic) float roundness; //Radius of corners incase you want a rounded rectangle. Defaults to half of width, creating a cirlce.
-(void)setRingColor:(UIColor *)color;

@end
