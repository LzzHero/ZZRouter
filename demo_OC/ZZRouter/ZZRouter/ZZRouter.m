//
//  ZZRouter.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "ZZRouter.h"
#import "ZZRouterCore.h"

@implementation ZZRouter

+ (ZZRouterBlock)sign {
    return ^(NSString *url,...) {
        
        va_list ap;
        va_start(ap,url);
        id obj=va_arg(ap,id);
        va_end(ap);
        
        if (url &&
            [url isKindOfClass:[NSString class]] &&
            url.length > 0) {
            [ZZRouterCore.core signPath:url targrtClass:obj];
        }
    };
}

+ (ZZRouterBlock)filter {
    return ^(NSString *url,...) {
        
        va_list ap;
        va_start(ap,url);
        id obj=va_arg(ap,id);
        va_end(ap);
        
        if (url &&
            [url isKindOfClass:[NSString class]] &&
            url.length > 0) {
            [ZZRouterCore.core signFilter:url targrtClass:obj];
        }
    };
}

+ (ZZRouterBlock)unit {
    return ^(NSString *url,...) {
        
        va_list ap;
        va_start(ap,url);
        id obj=va_arg(ap,id);
        va_end(ap);
        
        if (url &&
            [url isKindOfClass:[NSString class]] &&
            url.length > 0) {
            [ZZRouterCore.core signUnit:url targrtClass:obj];
        }
    };
}

+ (ZZRouterBlock)load {
    return ^(NSString *url,...) {
        
        va_list ap;
        va_start(ap,url);
        id obj=va_arg(ap,id);
        va_end(ap);
        
        if (url &&
            [url isKindOfClass:[NSString class]] &&
            url.length > 0) {
            [ZZRouterCore.core loadUrl:url params:obj];
        }
    
    };
}

@end
