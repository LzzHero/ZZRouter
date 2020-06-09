//
//  ZZRouterCore.h
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZRouterCore : NSObject

+ (instancetype)core;

- (void)signPath:(NSString *)url targrtClass:(Class)targetClass;
- (void)signFilter:(NSString *)url targrtClass:(Class)targetClass;
- (void)signUnit:(NSString *)url targrtClass:(Class)targetClass;

- (void)loadUrl:(NSString *)url params:(nullable id)obj;

@end

NS_ASSUME_NONNULL_END
