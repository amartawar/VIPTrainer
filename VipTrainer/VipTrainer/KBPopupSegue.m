//
//  KBSlideUpSegue.m
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBPopupSegue.h"

@implementation KBPopupSegue
- (void) perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    dst.view.transform = CGAffineTransformMakeScale(.9, .9);
    dst.view.alpha = 1;
    //src.view.transform = CGAffineTransformMakeTranslation(0, 0);
    
    

    [UIView transitionWithView:src.navigationController.view duration:.2
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                
                        
                        dst.view.transform = CGAffineTransformIdentity;
                        dst.view.alpha = 1;
                        //src.view.transform = CGAffineTransformMakeTranslation(0, -src.view.frame.size.height);
                        
                            [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:^(BOOL finished) {
                    }];
    

}
@end
