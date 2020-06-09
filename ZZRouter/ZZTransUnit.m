//
//  ZZTransUnit.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "ZZTransUnit.h"

@implementation ZZTransUnit

- (void)dealMessageWithtargetObject:(id)toObject params:(nonnull id)param dealFinished:(nonnull void (^)(BOOL finished))complete {
    
    [self dealLoad:toObject params:param dealFinished:complete];
}

#pragma mark - load

- (void)dealLoad:(id)toObject params:(id)param dealFinished:(nonnull void (^)(BOOL finished))complete{
    
    if (![toObject isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    UIViewController *vc = (UIViewController *)toObject;
    UINavigationController *nav = [self selectNavigationController];
    [nav pushViewController:vc animated:YES];
    if (complete) {
        complete(YES);
    }
}

#pragma mark - privite

- (UINavigationController *)selectNavigationController {
    UINavigationController *navigationController = [self currentViewController].navigationController;
    if (!navigationController) {
        navigationController = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    }
    if (![navigationController isKindOfClass:[UINavigationController class]] || !navigationController) {
        return nil;
    }
    return navigationController;
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
