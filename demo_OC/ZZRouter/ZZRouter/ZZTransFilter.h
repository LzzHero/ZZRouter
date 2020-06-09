//
//  ZZTransFilter.h
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZTransFilter : NSObject

//在消息转发前调用(unit接收deal事件前)
//返回true 则通过。返回false，则不通过。
//对于同一url的多个filter，返回结果取 &
//对于路径调用，只会阻拦当前模块的调用，不会阻拦路径后面的调用
//可以使用 "*" 来匹配所有的路由，但是一个工程中只能有一个 "*" 的filter，多个该filter以最后加载的为准
- (BOOL)willTransRouter:(NSString *)url toViewObj:(id)toObject params:(id)param;

@end

NS_ASSUME_NONNULL_END
