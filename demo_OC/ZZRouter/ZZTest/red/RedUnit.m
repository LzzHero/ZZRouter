//
//  RedUnit.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "RedUnit.h"
#import "ZZRouter.h"
#import "RedViewController.h"

@implementation RedUnit

+ (void)load {
    RouterUnit(@"red")
}

- (void)dealMessageWithtargetObject:(id)toObject params:(id)param dealFinished:(void (^)(BOOL))complete {
    
    if ([toObject isKindOfClass:[RedViewController class]]) {

        RedViewController *vc = (RedViewController *)toObject;
        vc.dataDictionary = (NSDictionary *)param;
    }
    
    [super dealMessageWithtargetObject:toObject params:param dealFinished:complete];
}

@end
