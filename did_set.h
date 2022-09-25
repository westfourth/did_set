//
//  did_set.h
//  PromiseKit
//
//  Created by hanxin on 2022/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
    obj.key = newValue 调用setter方法时触发

    @param block       原型为：void (^)(id newValue)，newValue不仅仅可以为id、Class、SEL类型（block也属于id类型），
                    也可以为C语言基本类型（char, int, long, float, double......BOOL），以及char*、void*

    @note  obj持有block，使用时注意循环引用。  obj释放时，block也被释放（循环引用时不会被释放）。
 */
void did_set(id obj, NSString *key, id block);


NS_ASSUME_NONNULL_END




//MARK: -   文档（typeEncoding）

/**
 下面的属性说明都是getter方法的typeEncoding
 
 @code
 
 struct Side {
     int left;
     int right;
 };

 typedef struct Triangle {
     int a;
     char b;
     double d;
 } Triangle;

 @interface Test : NSObject

 //  B16@0:8
 @property (nonatomic) BOOL enabled;

 //  i16@0:8
 @property (nonatomic) int age;

 //  f16@0:8
 @property (nonatomic) float money;

 //  *16@0:8
 @property (nonatomic) char *str;

 //  @16@0:8
 @property (nonatomic) NSString *names;

 //  #16@0:8
 @property (nonatomic) Class cls;

 //  :16@0:8
 @property (nonatomic) SEL sel;

 //  @?16@0:8
 @property (nonatomic) void (^block)(void);

 //  ^?16@0:8
 @property (nonatomic) void (*func)(void);

 //  ^v16@0:8
 @property (nonatomic) void *data;

 //  {Side=ii}16@0:8
 @property (nonatomic) struct Side side;

 //  ^{Side=ii}16@0:8
 @property (nonatomic) struct Side *sidePtr;

 //  {Triangle=icd}16@0:8
 @property (nonatomic) Triangle angle;

 //  ^{Triangle=icd}16@0:8
 @property (nonatomic) Triangle *anglePtr;

 @end
 
 @endcode
 */

