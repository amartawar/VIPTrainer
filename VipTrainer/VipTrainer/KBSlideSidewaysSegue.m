//
//  KBSlideUpSegue.m
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBSlideSidewaysSegue.h"

@implementation KBSlideSidewaysSegue
- (void) perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    dst.view.transform = CGAffineTransformMakeTranslation(0, src.view.frame.size.height);
    src.view.transform = CGAffineTransformMakeTranslation(0, 0);
    
    

    [UIView transitionWithView:src.navigationController.view duration:.2
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                
                        
                        
                        dst.view.transform = CGAffineTransformMakeTranslation(0, 0);
                        src.view.transform = CGAffineTransformMakeTranslation(0, -src.view.frame.size.height);
                        
                            [src.navigationController presentViewController:dst animated:NO completion:nil];
                    }
                    completion:^(BOOL finished) {
                    }];
    

}
@end
