//
//  ZZRouterCore.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "ZZRouterCore.h"
#import "ZZTransFilter.h"
#import "ZZTransUnit.h"

@interface ZZRouterCore ()

//路由表
@property (nonatomic, strong) NSMutableDictionary *routerMap;

//转发单元表
@property (nonatomic, strong) NSMutableDictionary *unitMap;

//过滤器表
@property (nonatomic, strong) NSMutableDictionary *filterMap;

@end

@implementation ZZRouterCore

#pragma mark - init

+ (instancetype)core {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - sign

- (void)signPath:(NSString *)url targrtClass:(Class)targetClass {
    [self.routerMap setObject:NSStringFromClass(targetClass) forKey:url];
}

- (void)signFilter:(NSString *)url targrtClass:(Class)targetClass {
    [self.filterMap setObject:NSStringFromClass(targetClass) forKey:url];
}

- (void)signUnit:(NSString *)url targrtClass:(Class)targetClass {
    [self.unitMap setObject:NSStringFromClass(targetClass) forKey:url];
}


#pragma mark - load

- (void)loadUrl:(NSString *)url params:(nullable id)obj {
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:1];
    if ([url containsString:@"/"]) {
        NSArray *array = [url componentsSeparatedByString:@"/"];
        resultArray = [array mutableCopy];
    } else {
        [resultArray addObject:url];
    }
    [self stepLoadUrl:resultArray params:obj];
}

- (void)stepLoadUrl:(NSMutableArray *)urlArray params:(nullable id)obj {
    
    if (urlArray.count == 0) {
        return;
    }
    
    NSString *url = [urlArray firstObject];
    __weak typeof(self) weakself = self;
    [self loadRouterWithUrl:url params:obj finish:^(BOOL finished) {
        __strong typeof(weakself) strongSelf = weakself;
        
        [urlArray removeObjectAtIndex:0];
        [strongSelf stepLoadUrl:urlArray params:obj];
        
    }];
}

#pragma mark - loadRoute

- (void)loadRouterWithUrl:(NSString *)url params:(nullable id)obj finish:(nonnull void (^)(BOOL finished))complete{
    
    NSString *classString = [self.routerMap objectForKey:url];
    if (!classString) {
        if (complete) {
            complete(YES);
        }
        return;
    }
    Class objClass = NSClassFromString(classString);
    id item = [[objClass alloc] init];
    if (!item) {
        if (complete) {
            complete(YES);
        }
        return;
    }
    
    //1、寻找过滤器
    BOOL canGo = [self loadFilter:url toClass:item param:obj];
    if (!canGo) {
        if (complete) {
            complete(YES);
        }
        return;
    }
    
    //2、寻找消息转发单元，进行消息转发
    ZZTransUnit *unit = [self createAUnit:url];
    if (unit) {
        [unit dealMessageWithtargetObject:item params:obj dealFinished:complete];
    }
}

- (BOOL)loadFilter:(NSString *)url toClass:(id)toObj param:(id)param {
    
    NSMutableArray *filterArray = [NSMutableArray array];
    for (NSString *content in self.filterMap.allKeys) {
        
        //对 * 进行处理
        if ([@"*" isEqualToString:content]) {
            ZZTransFilter *filter = [self createAFilter:content];
            if (filter) {
                [filterArray addObject:filter];
                continue;
            }
        }
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", content];
        if ([pred evaluateWithObject:url]) {
            ZZTransFilter *filter = [self createAFilter:content];
            if (filter) {
                [filterArray addObject:filter];
                continue;
            }
        }
    }
        
    if (filterArray.count > 0) {
        BOOL canGo = YES;
        for (ZZTransFilter *filter in filterArray) {
            BOOL filterCanGo = [filter willTransRouter:url toViewObj:toObj params:param];
            canGo = (canGo && filterCanGo);
        }
        return canGo;
    }
    
    return YES;
}

#pragma mark - privite

- (ZZTransUnit *)createAUnit:(NSString *)url {
    NSString *unitString = [self.unitMap objectForKey:url];
    ZZTransUnit *unit = [[ZZTransUnit alloc] init];
    if (unitString && ![@"" isEqualToString:unitString]) {
        Class unitClass = NSClassFromString(unitString);
        unit = (ZZTransUnit *)[[unitClass alloc] init];
    }
    return unit;
}

- (ZZTransFilter *)createAFilter:(NSString *)url {
    NSString *filterString = [self.filterMap objectForKey:url];
    ZZTransFilter *filter = nil;
    if (filterString && ![@"" isEqualToString:filterString]) {
        Class filterClass = NSClassFromString(filterString);
        filter = [(ZZTransFilter *)[filterClass alloc] init];
        if (filter) {
            return filter;
        }
    }
    return nil;
}

#pragma mark - getter

- (NSMutableDictionary *)routerMap {
    if (_routerMap == nil) {
        _routerMap = [NSMutableDictionary dictionary];
    }
    return _routerMap;
}

- (NSMutableDictionary *)unitMap {
    if (_unitMap == nil) {
        _unitMap = [NSMutableDictionary dictionary];
    }
    return _unitMap;
}

- (NSMutableDictionary *)filterMap {
    if (_filterMap == nil) {
        _filterMap = [NSMutableDictionary dictionary];
    }
    return _filterMap;
}

@end
