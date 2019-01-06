//
//  ShowViewController.m
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/5.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import "ShowViewController.h"
#import "CommonView2ViewTransitionProtocol.h"

@interface ShowViewController()<CommonView2ViewTransitionProtocol>

@end

@implementation ShowViewController
{
       UIView * _targetView;
}

- (void)dealloc{
    NSLog(@">>>>>>>>>>dealloc>>>>>>>>>>>>");
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"12345";
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onCancel:)];
    
    UIView * greenView = [[UIView alloc] initWithFrame:CGRectMake(50,150, 100, 100)];
    
    greenView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:greenView];
    
    _targetView = greenView;
}

- (void)onCancel:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)getReadyForCommonView2ViewTransition{
    
}
//结束转换 可以在这里做目标页面的展示
- (void)didFinishCommonView2ViewTranstion{
    
}
//要变换的原始view 用于计算位置
- (UIView*)commonView2ViewTransitionOriginView{
    return _targetView;
}
@end
