//
//  FilterOne.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "FilterOne.h"
#import "ZZRouter.h"
#import "RedViewController.h"

@implementation FilterOne

+ (void)load {
    RouterFilter(@"blue")
}

- (BOOL)willTransRouter:(NSString *)url toViewObj:(id)toObject params:(id)param {
    NSLog(@"one -- %@", toObject);
    return YES;
}

@end
