//
//  ZZTransFilter.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "ZZTransFilter.h"

@implementation ZZTransFilter

- (BOOL)willTransRouter:(NSString *)url toViewObj:(id)toObject params:(id)param {
    return YES;
}

@end
