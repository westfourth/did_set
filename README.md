#  setter观察器

## 使用说明

### 接口

```objc
/**
 obj.key = newValue 调用setter方法时触发
 
 @param block       原型为：void (^)(id newValue)，newValue不仅仅可以为id类型，也可以为C语言基本类型（BOOL, int, float......）
 */
void did_set(id obj, NSString *key, id block);
```

### 举例

```objc
@interface Test : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) BOOL enabled;
@property (nonatomic) int age;
@property (nonatomic) float money;

@end
```

**监听**

```objc
    self.t  = [Test new];

    did_set(self.t, @"name", ^(id  _Nullable newValue) {
        NSLog(@">>> %@", newValue);
    });
    
    did_set(self.t, @"enabled", ^(BOOL newValue) {
        NSLog(@">>> %d", newValue);
    });
    
    did_set(self.t, @"age", ^(int newValue) {
        NSLog(@">>> %d", newValue);
    });
    
    did_set(self.t, @"money", ^(float newValue) {
        NSLog(@">>> %f", newValue);
    });
```

**触发**

```objc
    self.t.name = @"ABC";
    self.t.enabled = YES;
    self.t.age = 100;
    self.t.money = 11.22;
```


## 原理

向`setter`中插入代码

```objc
- (void)setName:(NSString *)name {
	// 原来的实现
	...
	
	//	插入的代码
	for (id block in blockArray) {
		block(name);
	}
}
```

### 设计
>
1. 使用一个`BOOL`类型的`class property`标记该setter方法是否插入过代码。
1. 如果未插入过代码，则插入代码，并将该标记置为`YES`
1. 取出该对象关联的`block`数组，依次调用。


