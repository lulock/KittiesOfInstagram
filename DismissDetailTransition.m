//
//  DismissDetailTransition.m
//  Photo Bombers
//
//  Created by Lulu on 2015-08-09.
//  Copyright (c) 2015 Lulu. All rights reserved.
//

#import "DismissDetailTransition.h"

@implementation DismissDetailTransition

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    
    [UIView animateWithDuration:0.3
                     animations:^{
                         detail.view.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [detail.view removeFromSuperview];
                         [transitionContext  completeTransition:YES];
                     }];
}


@end
