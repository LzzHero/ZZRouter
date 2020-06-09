//
//  YellowUnit.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "YellowUnit.h"
#import "ZZRouter.h"

@implementation YellowUnit

+ (void)load {
    RouterUnit(@"yellow")
}

- (void)dealMessageWithtargetObject:(id)toObject params:(id)param dealFinished:(void (^)(BOOL))complete {
    [super dealMessageWithtargetObject:toObject params:param dealFinished:complete];
}


@end
