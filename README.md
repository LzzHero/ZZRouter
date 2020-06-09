# ZZRouter
A simple framework focusing only on Routing

## 安装


## 使用

ZZRouter分为路由的注册和使用两个阶段

### 注册一个路由

1、引入 <ZZRouter/ZZRouter.h>

2、在VC的 load 方法中 写入代码：

    + (void)load {
        RouterPath(@"name")
    }
    
    其中 name 为该模块（VC）的唯一标识

### 使用路由进行跳转

1、引入 <ZZRouter/ZZRouter.h>

2、调用以下代码即可完成跳转

    ZZRouter.load(@"name");
    
默认跳转方式为push

3、当然，如果在跳转中传递参数，只需如下操作即可

    ZZRouter.load(@"name",@{@"id":@"123"});


至此，恭喜你已经完成了对ZZRouter的接入

## 进一步操作

ZZRouter还提供了许多方法，可以自定义跳转事件和自定义转发的拦截，辅助完成各种业务场景

### 转发单元

ZZRouter实现页面的跳转，是依赖于转发单元。
每一个模块“name”，都对应一个转发单元“unit”（ZZTransUnit）
使用者可以自定义转发单元来实现跳转操作，如果没有自定义的实现，ZZRouter将会自动帮助你实现一个，并且默认为push操作

#### 自定义转发单元

你可以通过自定义转发单元来达到present，或者自定义VC切换动画的目的。

1、自定义的转发单元，需要继承自 ZZTransUnit

    @interface myUnit : ZZTransUnit
    @end
    
2、在 myUnit 的load方法中，注册转发单元
注意，这里的name必须和模块的name保持一致，这样才能准确地匹配模块

    + (void)load {
        RouterUnit(@"name")
    }
    
3、实现消息转发的方法

其中参数：
toObject -- 即将跳转的VC，或者可以理解为注册了 RouterPath(@"name") 的对象
param -- 在外部调用时外边传递的参数
complete -- 一个block，在自定义的事件处理完以后，需要调用该block(BOOL),他需要一个bool值，告诉是否成功完成自定义的跳转。此处在稍后的路径跳转会说明调用的原因。

你也可以直接调用super的方法，super的方法就是默认push到toObject

    - (void)dealMessageWithtargetObject:(id)toObject params:(id)param dealFinished:(void (^)(BOOL))complete {
        //[super dealMessageWithtargetObject:toObject params:param dealFinished:complete];
    }
    

至此，你已经自定义了转发单元，并可以在这里进行自定义的跳转操作。

### 拦截器

拦截器，顾名思义，针对一个或一种活一类路由进行过滤，只通过想要通过的路由。
当消息发送给转发单元前，会先被拦截器拦截

#### 自定义拦截器

ZZRouter本身不自带任何拦截器，如果需要拦截，要自定义拦截器使用。

1、拦截器，要继承自 ZZTransFilter

    @interface MyFilter : ZZTransFilter
    @end
    
2、在 MyFilter 的load方法中，注册拦截器

这里的name，你可以直接传入与 RouterPath(@"name") 同样的那name，这样这个拦截器只对这个路由起作用

你也可以传入一个正则表达式，来匹配与之相符的所有跳转
比如：RouterFilter(@"name1|name2") 
如果你想匹配所有的路由，可以用：RouterFilter(@"*")但是，为\*的过滤器只能有一个，多个会以最后加载的为主

    + (void)load {
        RouterFilter(@"name")
    }
    
3、实现拦截的方法

其中参数：
url -- 路由的name，即调用的路由地址
toObject -- 即将跳转的VC，或者可以理解为注册了 RouterPath(@"name") 的对象
param -- 在外部调用时外边传递的参数

返回参数：
需要一个BOOL值，若为true，则通过校验。若为false，则不通过，消息不会转发给后面的转发单元

    - (BOOL)willTransRouter:(NSString *)url toViewObj:(id)toObject params:(id)param {
        return YES;
    }
    
说明：
一个路由，如果有多个拦截器拦截，则对所有拦截器的返回结果做与操作，都满足才会继续转发。

至此，你已经可以使用拦截器去拦截路由了


### 路径跳转


路径跳转是ZZRouter特有的功能，它可以支持如下调用：

    ZZRouter.load(@"name1/name2/name3");
    
这样，可以首先跳转到name1界面，然后跳转到name2界面，最后在跳转到name3界面。
如果其中有自定义的unit的filter的话，就是如下解释：

    1、执行name1所有的filter，若通过，执行name1对应的unit
    2、执行name2所有的filter，若通过，执行name2对应的unit
    3、执行name3所有的filter，若通过，执行name3对应的unit

想要实现路径调用，很重要的一点就是在自定义unit的时候，在自定义跳转结束以后，需要调用complete这个block，并且传入一个BOOL类型的跳转结果。若为YES，则会继续传递下一个路由进行跳转，若为NO，则停止传递。

#### 问题说明

关于路径跳转，有以下几种问题，在此意义说明：

1、对于自定义unit，若不调用complete，则在执行到该路径后，就无法继续执行下去了。所以推荐执行。

2、对于传参，在一开始进行的参数
比如：ZZRouter.load(@"name1/name2/name3",@{@"name":@"123"});
其中的参数会传递到所有的filter和unit

3、对于filter，只会拦截路径上的某一个路由的执行，不会阻断整条路径的执行。
比如路由为：ZZRouter.load(@"name1/name2/name3");
这个时候，对于name2的filter返回的是false，name1和name3返回的都是true，则上面的调用等价于“
ZZRouter.load(@"name1/name3");

想要阻断路径跳转的话，请在unit中，complete传入false

### 重置（replace）

重制是ZZRouter自带的一个已经实现的转发单元，他的路由是 zz_replace
通过调用 ZZRouter.load(@"zz_replace");
可以直接回到根视图控制器。（可以越过多级push和present）

以下调用：
ZZRouter.load(@"zz_replace/name1");
便是：首先回到根目录，然后在进入name1

## 一些范例的实现

如果你看到这里，那么恭喜你，你已经知道了ZZRouter的全部功能。
本人针对项目中实际应用的场景，给出几种场景下应用ZZRouter的思路，供大家参考

### 公共参数

项目里经常会遇到的就是公共参数，对于每一个VC，都需要把一些通用的参数在传递的时候进行赋值。
这样的话，在ZZRouter里面，就是一个Filter

1、自定义公共参数的filter

    @interface ParamsFilter : ZZTransFilter
    @end
    
2、注册filter

    + (void)load {
        RouterFilter(@"*")
    }
    
3、实现拦截器

    - (BOOL)willTransRouter:(NSString *)url toViewObj:(id)toObject params:(id)param {
        [toObject addParams:……];
        return YES;
    }

### 登陆拦截

对于登陆操作，按理说应该由调用方自己做登陆判断，确认用户成功登录以后，在调用load方法进行跳转。
不过使用ZZRouter也可以实现登录验证。

1、注册一个unit，我们命名为登陆的unit

LoginUnit.h

    @interface LoginUnit : ZZTransUnit
    @end


LoginUnit.m

    + (void)load {
        RouterUnit(@"login")
        RouterPath(@"login")
    }

2、执行登陆逻辑

    - (void)dealMessageWithtargetObject:(id)toObject params:(id)param dealFinished:(void (^)(BOOL))complete {

        [YourLoginService login:^(BOOL success){
            complete(success);
        }];
    }

3、调用：

    ZZRouter.load(@"login/name1");


如此，在登陆成功后，就会执行complete，根据登陆成功与否，决定是否会进入name1

## 写在后面

ZZRouter还有很多功能等待挖掘。
如果想要联系我，可以给我发邮件，我的邮箱是：




