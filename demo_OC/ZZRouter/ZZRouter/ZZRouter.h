//
//  ZZRouter.h
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZZRouterBlock)(NSString *url,...);

//重置用的路径名
static NSString const *ZZReplaceName = @"zz_replace";

@interface ZZRouter : NSObject

//注册相关
//推荐在+load方法中调用，或者在你觉得合适的地方注册
//未注册的路由、过滤器、转发单元无法使用

//注册路由 url不支持正则传入，必须穿入完整的路由名
#define RouterPath(s) ZZRouter.sign(s,self.class);
@property (nonatomic, copy, class, readonly) ZZRouterBlock sign;

//注册过滤器 第一个url支持正则匹配，可匹配多个url进行拦截
#define RouterFilter(s) ZZRouter.filter(s,self.class);
@property (nonatomic, copy, class, readonly) ZZRouterBlock filter;

//注册转发单元 url不支持正则传入，必须穿入完整的路由名
#define RouterUnit(s) ZZRouter.unit(s,self.class);
@property (nonatomic, copy, class, readonly) ZZRouterBlock unit;


//跳转相关

//跳转路由
//url支持模块名，比如 ZZRouter.load(@"pageA") ，即为直接push到 pageA
//可以自定义unit，重写父类方法，达到自定义跳转的目的
//url支持路径，比如 ZZRouter.load(@"pageA/pageB")，即为先push到pageA，再push到pageB
//路由支持重制，在url前面添加："zz_replace/"
//如：ZZRouter.load(@"zz_replace/") 即可重置到根控制器(ZZReplaceName)
//同理 ZZRouter.load(@"zz_replace/pageA") 可以直接重置到根VC后跳转到pageA
@property (nonatomic, copy, class, readonly) ZZRouterBlock load;

@end

NS_ASSUME_NONNULL_END
