//
//  BlueUnit.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "BlueUnit.h"
#import "ZZRouter.h"

@implementation BlueUnit

+ (void)load {
    RouterUnit(@"blue");
}

- (void)dealMessageWithtargetObject:(id)toObject params:(id)param dealFinished:(void (^)(BOOL))complete {
    
    UIViewController *vc = [self currentViewController];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:(UIViewController *)toObject];
    
    [vc presentViewController:nav animated:YES completion:^{
        if (complete) {
            complete(YES);
        }
    }];
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
