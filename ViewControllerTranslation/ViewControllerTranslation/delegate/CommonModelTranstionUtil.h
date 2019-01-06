//
//  CommonModelTranstionUtil.h
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/6.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView2ViewTransitionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonModelTranstionUtil : NSObject

+ (id<CommonView2ViewTransitionProtocol>)comstomCtrIsImpView2View:(UIViewController*)ctr;

@end

NS_ASSUME_NONNULL_END
