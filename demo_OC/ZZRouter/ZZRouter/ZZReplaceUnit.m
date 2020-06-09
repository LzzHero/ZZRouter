//
//  ZZReplaceUnit.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "ZZReplaceUnit.h"
#import "ZZRouter.h"

@interface ZZReplaceUnit ()

@property (nonatomic, copy) void(^replaceBlock)(void);

@end

@implementation ZZReplaceUnit

+ (void)load {
    RouterPath(@"zz_replace");
    RouterUnit(@"zz_replace");
}

- (void)dealMessageWithtargetObject:(id)toObject params:(id)param dealFinished:(void (^)(BOOL))complete {
    [self dealReplace:toObject params:param dealFinished:complete];
}

- (void)dealReplace:(id)toObject params:(id)param dealFinished:(nonnull void (^)(BOOL finished))complete {
    
    self.replaceBlock = ^(){
        if (complete) {
            complete(YES);
        }
    };
    
    [self stepVc];
    
}

//递归回到最底部的VC
- (void)stepVc {
    
    UIViewController *vc = [self currentViewController];
    if (vc.presentingViewController == nil && vc.navigationController.viewControllers.count == 1) {
        if (self.replaceBlock) {
            self.replaceBlock();
        }
        return;
    }
    if (vc.navigationController.viewControllers.count > 1) {
        [vc.navigationController popToRootViewControllerAnimated:NO];
    }
    
    vc = [self currentViewController];
    if (vc.presentingViewController) {
        [vc dismissViewControllerAnimated:NO completion:^{
            [self stepVc];
            return;
        }];
    } else {
        [self stepVc];
    }
    
}

- (UIViewController *)currentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

// 通过递归拿到当前控制器
- (UIViewController *)currentViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    } else if (viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}


@end
