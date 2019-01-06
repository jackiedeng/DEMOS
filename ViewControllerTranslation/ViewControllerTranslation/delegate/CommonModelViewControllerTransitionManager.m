//
//  ViewTransitionManager.m
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/5.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import "CommonModelViewControllerTransitionManager.h"
#import "CommonModelDismissedStyle.h"
#import "CommonModelPresentStyle.h"
#import <Accelerate/Accelerate.h>

@interface CommonModelViewControllerTransitionManager()
{
    NSMapTable * _vc2gestureMap;
    NSMapTable * _gesture2vcMap;
    
    CommonModelDismissedStyle * _dismissStyle;
    CommonModelPresentStyle * _presentStyle;
    
    UIPercentDrivenInteractiveTransition * _precentIneractiveTransition;
}
@end

@implementation CommonModelViewControllerTransitionManager

+ (instancetype)instance{
    static CommonModelViewControllerTransitionManager * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [CommonModelViewControllerTransitionManager new];
    });
    
    return manager;
}

- (id)init{
    
    self = [super init];
    
    if(self){
        
        _precentIneractiveTransition = nil;
        
        _vc2gestureMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory
                                                   valueOptions:NSPointerFunctionsWeakMemory
                                                       capacity:10];
        
        _gesture2vcMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory
                                                   valueOptions:NSPointerFunctionsWeakMemory
                                                       capacity:10];
        
        _dismissStyle = [CommonModelDismissedStyle new];
        _presentStyle = [CommonModelPresentStyle new];
    }
    
    return self;
    
}
//
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
//    return _precentIneractiveTransition;
//}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
  
    return _precentIneractiveTransition;
}

//- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//
//    NSLog(@"start inerfactive %@",transitionContext);
//
//}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    //add gesture when enter
    UIScreenEdgePanGestureRecognizer * gesture = [_vc2gestureMap objectForKey:presented];
    
    if(gesture == nil){
        
        gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleGesture:)];
        gesture.edges = UIRectEdgeLeft;
        
        [presented.view addGestureRecognizer:gesture];
        
        [_gesture2vcMap setObject:presented
                           forKey:gesture];
        
        [_vc2gestureMap setObject:gesture
                           forKey:presented];
        
    }
    
    return _presentStyle;
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return _dismissStyle;
}


-(void)handleGesture:(UIScreenEdgePanGestureRecognizer*)gesture{

    float progress = fabs([gesture translationInView:[UIApplication sharedApplication].keyWindow].x/[UIApplication sharedApplication].keyWindow.bounds.size.width);
    
    if([gesture state] == UIGestureRecognizerStateBegan){
        
        _precentIneractiveTransition = [UIPercentDrivenInteractiveTransition new];
        
        UIViewController * currentController = [_gesture2vcMap objectForKey:gesture];
        
        [currentController dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        
        [_precentIneractiveTransition updateInteractiveTransition:progress];
    }else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled){
        
        if(progress > 0.5){
            [_precentIneractiveTransition finishInteractiveTransition];
        }else{
            [_precentIneractiveTransition cancelInteractiveTransition];
        }
        _precentIneractiveTransition = nil;
    }
    
}

@end
