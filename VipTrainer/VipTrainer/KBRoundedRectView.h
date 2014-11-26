//
//  RoundedRectView.h
//  Vendevor
//
//  Created by kyle barnes on 5/3/13.
//
//

#import <UIKit/UIKit.h>
#import "Colors.h"

@interface KBRoundedRectView : UIView{
}


@property (nonatomic, weak) UIColor *background_color;
@property (nonatomic) float backgroundAlpha;
@property (nonatomic) BOOL topLeftRounded;
@property (nonatomic) BOOL topRightRounded;
@property (nonatomic) BOOL bottomLeftRounded;
@property (nonatomic) BOOL bottomRightRounded;
@property (nonatomic) Colors color;

-(void)setTop;
-(void)setBottom;
-(void)setAll;
@end
