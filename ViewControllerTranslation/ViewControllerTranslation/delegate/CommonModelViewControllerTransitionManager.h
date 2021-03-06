//
//  ViewTransitionManager.h
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/5.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonModelViewControllerTransitionManager : NSObject<UIViewControllerTransitioningDelegate>

+ (instancetype)instance;

@end

NS_ASSUME_NONNULL_END
