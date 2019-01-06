//
//  CommonView2ViewTransitionProtocol.h
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/6.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define COMMON_TRANSITION_DURATION 1.0

@protocol CommonView2ViewTransitionProtocol <NSObject>
@required
//转换开始前调用，一般在这里做一些隐藏工作
- (void)getReadyForCommonView2ViewTransition;
//结束转换 可以在这里做目标页面的展示
- (void)didFinishCommonView2ViewTranstion;
//要变换的原始view 用于计算位置
- (UIView*)commonView2ViewTransitionOriginView;


@end

NS_ASSUME_NONNULL_END
