//
//  CommonModelDismissedStyle.m
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/6.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import "CommonModelDismissedStyle.h"
#import "CommonView2ViewTransitionProtocol.h"
#import "CommonModelTranstionUtil.h"

@implementation CommonModelDismissedStyle

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * fromVctr = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVctr = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
    id<CommonView2ViewTransitionProtocol> fromDelegate = [CommonModelTranstionUtil comstomCtrIsImpView2View:fromVctr];
    id<CommonView2ViewTransitionProtocol> toDelegate = [CommonModelTranstionUtil comstomCtrIsImpView2View:toVctr];
    
    if(fromDelegate && toDelegate){
        
        [self animateView2ViewTransition:transitionContext
                                    from:fromDelegate
                                      to:toDelegate];
        
    }else{
        
        UIView * contentView = [transitionContext containerView];
        
        
        UIView * snapShotView = [fromVctr.view snapshotViewAfterScreenUpdates:YES];
        
        UIView * maskView= [[UIView alloc] initWithFrame:snapShotView.bounds];
        
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.8;
        
        [contentView addSubview:toVctr.view];
        [toVctr.view addSubview:maskView];
        [contentView addSubview:snapShotView];
        
        
        CGRect rect = [transitionContext finalFrameForViewController:toVctr];
        CGRect beginRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, rect.size.width, rect.size.height);
        
        toVctr.view.frame = rect;
        
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             maskView.alpha = 0;
                             snapShotView.frame = beginRect;
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [snapShotView removeFromSuperview];
                             [maskView removeFromSuperview];
                             if([transitionContext transitionWasCancelled]){
                                 [toVctr.view removeFromSuperview];
                             }
                             
                             NSLog(@"%d is canceled",[transitionContext transitionWasCancelled]);
                             [transitionContext completeTransition:
                              ![transitionContext transitionWasCancelled]];
                         }];
        
    }
    
}


- (void)animateView2ViewTransition:(id <UIViewControllerContextTransitioning>)transitionContext
                              from:(id<CommonView2ViewTransitionProtocol>)fromDelegate
                                to:(id<CommonView2ViewTransitionProtocol>)toDelegate{
    
    NSLog(@"view2view");
    
    UIViewController * fromVctr = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVctr = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * contentView = [transitionContext containerView];
    
    [fromDelegate getReadyForCommonView2ViewTransition];
    [toDelegate getReadyForCommonView2ViewTransition];
    
    //原始view
    UIView * fromTransitionView = [fromDelegate commonView2ViewTransitionOriginView];
    UIView * toTransitionView = [toDelegate commonView2ViewTransitionOriginView];
    
    //真正做动画的view
    UIView * fromAnimationView = [fromTransitionView snapshotViewAfterScreenUpdates:YES];
    fromAnimationView.layer.anchorPoint = CGPointMake(0.5,0.5);
    UIView * toAnimationView = [toTransitionView snapshotViewAfterScreenUpdates:YES];
    toAnimationView.layer.anchorPoint = CGPointMake(0.5,0.5);
    
    //隐藏原始view
    fromTransitionView.alpha = 0;
    toTransitionView.alpha = 0;
    
    //模态相反
    UIView * toSnapShotView = [toVctr.view snapshotViewAfterScreenUpdates:YES];
    UIView * fromSnapShotView = [fromVctr.view snapshotViewAfterScreenUpdates:YES];
    
    UIView * maskView= [[UIView alloc] initWithFrame:fromSnapShotView.bounds];
    
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 1;
    
    [contentView addSubview:toSnapShotView];
    [toSnapShotView addSubview:maskView];
    [contentView addSubview:fromSnapShotView];
    
    [contentView addSubview:fromAnimationView];
    [contentView addSubview:toAnimationView];
    
    
    //准备动画状态
    
    //vc 的位置
    CGRect beginRect = [transitionContext finalFrameForViewController:toVctr];
    CGRect targetRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, beginRect.size.width, beginRect.size.height);
    
    fromSnapShotView.frame = beginRect;
    toSnapShotView.frame = beginRect;
    
    CGRect viewFromRect = [fromTransitionView convertRect:fromTransitionView.bounds
                                                   toView:contentView];
    CGRect viewToRect = [toTransitionView convertRect:toTransitionView.bounds
                                               toView:contentView];
    
    CGPoint fromCenter = CGPointMake(CGRectGetMidX(viewFromRect),CGRectGetMidY(viewFromRect));
    CGPoint toCenter = CGPointMake(CGRectGetMidX(viewToRect),CGRectGetMidY(viewToRect));
    
    fromAnimationView.center = fromCenter;
    toAnimationView.center = fromCenter;
    
    fromAnimationView.alpha = 1;
    toAnimationView.alpha = 0;
    
    float fromScaleWidth = toAnimationView.frame.size.width/fromAnimationView.frame.size.width;
    float fromScaleHeight = toAnimationView.frame.size.height/fromAnimationView.frame.size.height;
    
    float duartion = COMMON_TRANSITION_DURATION;
    float step = 1/3.0;
    
    [UIView animateKeyframesWithDuration:duartion
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:1
                                                                animations:^{
                                                                    
                                                                    fromSnapShotView.frame = targetRect;
                                                                    fromAnimationView.center = toCenter;
                                                                    toAnimationView.center = toCenter;
                                                                    maskView.alpha = 0;
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:step
                                                                animations:^{
                                                                    
                                                                    fromAnimationView.transform = CGAffineTransformMakeScale(fromScaleWidth, fromScaleHeight);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:step/2
                                                          relativeDuration:step
                                                                animations:^{
                                                                    
                                                                    fromAnimationView.alpha = 0;
                                                                    toAnimationView.alpha = 1;
                                                                }];
                                  
                              }
                              completion:^(BOOL finished) {
                                  
                                  [toSnapShotView removeFromSuperview];
                                  [fromSnapShotView removeFromSuperview];
                                  [fromAnimationView removeFromSuperview];
                                  [toAnimationView removeFromSuperview];
                                  
                                  [contentView addSubview:toVctr.view];
                                  
                                  [toDelegate didFinishCommonView2ViewTranstion];
                                  [fromDelegate didFinishCommonView2ViewTranstion];
                                  
                                  fromTransitionView.alpha = 1;
                                  toTransitionView.alpha = 1;
                                  
                                  if([transitionContext transitionWasCancelled]){
                                      [toVctr.view removeFromSuperview];
                                  }
                                  
                                  NSLog(@"%d is canceled",[transitionContext transitionWasCancelled]);
                                  [transitionContext completeTransition:
                                   ![transitionContext transitionWasCancelled]];
                              }];
    
    
}
@end
