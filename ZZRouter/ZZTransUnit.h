//
//  ZZTransUnit.h
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/5.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZTransUnit : NSObject

//自定义处理路由事件
//默认执行push方法，若present，请自行定义unit实现
//其中
//toObject为响应事件的对象，一般为VC
//param为传来的参数
//complete为处理结束事件，自定义unit需调用该事件，以保证可以继续调用下一个unit
- (void)dealMessageWithtargetObject:(id)toObject params:(nonnull id)param dealFinished:(nonnull void (^)(BOOL finished))complete;

@end

NS_ASSUME_NONNULL_END
