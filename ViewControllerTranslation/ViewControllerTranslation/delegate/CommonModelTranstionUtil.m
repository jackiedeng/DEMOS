//
//  CommonModelTranstionUtil.m
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/6.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import "CommonModelTranstionUtil.h"

@implementation CommonModelTranstionUtil

+ (id<CommonView2ViewTransitionProtocol>)comstomCtrIsImpView2View:(UIViewController*)ctr{
    
    if([ctr isKindOfClass:[UINavigationController class]]){
        ctr = [(UINavigationController*)ctr topViewController];
    }
    
    return [ctr conformsToProtocol:@protocol(CommonView2ViewTransitionProtocol)]?(id<CommonView2ViewTransitionProtocol>)ctr:nil;
}
@end
