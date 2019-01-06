//
//  ViewController.m
//  ViewControllerTranslation
//
//  Created by Chao Deng on 2019/1/5.
//  Copyright © 2019 Chao Deng. All rights reserved.
//

#import "ViewController.h"
#import "CommonModelViewControllerTransitionManager.h"
#import "ShowViewController.h"
#import "CommonView2ViewTransitionProtocol.h"

@interface ViewController ()<CommonView2ViewTransitionProtocol>
{
    UIView * _targetView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test2.png"]];
    [self.view addSubview:imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button setFrame:CGRectMake(0, 100, 200, 40)];
    
    [button setTitle:@"click me" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button];
    
//    self.transitioningDelegate = [ViewTransitionManager instance];
    
    UIView * transView = [[UIView alloc] initWithFrame:CGRectMake(200, 400, 150, 150)];
    
    transView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:transView];
    
    _targetView = transView;
}

- (void)onClick:(id)sender{
    
    
    ShowViewController * ShowViewCtr = [ShowViewController new];
    
    UINavigationController * navigation =  [[UINavigationController alloc] initWithRootViewController:ShowViewCtr];
  

    navigation.transitioningDelegate = [CommonModelViewControllerTransitionManager instance];
//    navigation.transitioningDelegate = [ViewInteractiveTransitionManager instance];
    
    [self presentViewController:navigation
                       animated:YES
                     completion:^{
                         
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
