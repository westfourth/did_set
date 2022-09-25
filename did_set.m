//
//  did_set.m
//  PromiseKit
//
//  Created by hanxin on 2022/9/16.
//

#import "did_set.h"
#import <objc/runtime.h>
#import <objc/objc-sync.h>

#define AFTER_DID_SET(type) \
__attribute__((overloadable)) \
static void after_did_set(id obj, SEL sel, type newValue) { \
    NSMutableArray *array = instance_get_array(obj, sel); \
    for (int i = 0; i < array.count; i++) { \
        void (^block)(type newValue) = array[i]; \
        block(newValue); \
    } \
}


//MARK: -   属性

//  类属性getter
static BOOL class_get_bool(Class cls, SEL sel) {
    return [objc_getAssociatedObject(cls, sel) boolValue];
}

//  类属性setter
static void class_set_bool(Class cls, SEL sel, BOOL flag) {
    objc_setAssociatedObject(cls, sel, @(flag), OBJC_ASSOCIATION_ASSIGN);
}

//  属性getter
static NSMutableArray* _Nullable instance_get_array(id obj, SEL sel) {
    return objc_getAssociatedObject(obj, sel);
}

//  属性setter
static void instance_set_array(id obj, SEL sel, NSMutableArray* _Nullable array) {
    objc_setAssociatedObject(obj, sel, array, OBJC_ASSOCIATION_RETAIN);
}



//MARK: -   方法重载

AFTER_DID_SET(char)
AFTER_DID_SET(unsigned char)
AFTER_DID_SET(short)
AFTER_DID_SET(unsigned short)

AFTER_DID_SET(int)
AFTER_DID_SET(unsigned int)
AFTER_DID_SET(long)
AFTER_DID_SET(unsigned long)

AFTER_DID_SET(long long)
AFTER_DID_SET(unsigned long long)
AFTER_DID_SET(float)
AFTER_DID_SET(double)
AFTER_DID_SET(bool)

AFTER_DID_SET(id)
AFTER_DID_SET(Class)
AFTER_DID_SET(SEL)
AFTER_DID_SET(char *)
AFTER_DID_SET(void *)


//MARK: -   构建setter新方法

/**
    构建setter新方法
 
    @param  imp0            原setter实现
    @param  setSEL       原setter
    @param  keySEL        属性名称
    @param  type            属性声明类型
 
    @return 返回block实现
 */
static id imp_new_block(IMP imp0, SEL setSEL, SEL keySEL, char type) {
    id block = nil;
    switch (type) {
        case _C_CHR:
            block = ^void(id obj, char newValue) {
                ((void (*)(id, SEL, char))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_UCHR:
            block = ^void(id obj, unsigned char newValue) {
                ((void (*)(id, SEL, unsigned char))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_SHT:
            block = ^void(id obj, short newValue) {
                ((void (*)(id, SEL, short))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_USHT:
            block = ^void(id obj, unsigned short newValue) {
                ((void (*)(id, SEL, unsigned short))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_INT:
            block = ^void(id obj, int newValue) {
                ((void (*)(id, SEL, int))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_UINT:
            block = ^void(id obj, unsigned int newValue) {
                ((void (*)(id, SEL, unsigned int))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_LNG:
            block = ^void(id obj, long newValue) {
                ((void (*)(id, SEL, long))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_ULNG:
            block = ^void(id obj, unsigned long newValue) {
                ((void (*)(id, SEL, unsigned long))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_LNG_LNG:
            block = ^void(id obj, long long newValue) {
                ((void (*)(id, SEL, long long))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_ULNG_LNG:
            block = ^void(id obj, unsigned long long newValue) {
                ((void (*)(id, SEL, unsigned long long))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_FLT:
            block = ^void(id obj, float newValue) {
                ((void (*)(id, SEL, float))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_DBL:
            block = ^void(id obj, double newValue) {
                ((void (*)(id, SEL, double))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_BOOL:
            block = ^void(id obj, BOOL newValue) {
                ((void (*)(id, SEL, BOOL))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_ID:
            block = ^void(id obj, id newValue) {
                ((void (*)(id, SEL, id))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_CLASS:
            block = ^void(id obj, Class newValue) {
                ((void (*)(id, SEL, Class))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_SEL:
            block = ^void(id obj, SEL newValue) {
                ((void (*)(id, SEL, SEL))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        case _C_CHARPTR:
            block = ^void(id obj, char* newValue) {
                ((void (*)(id, SEL, char*))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
        case _C_PTR:        //  调用时，char*类型的会执行下面的block。？？为什么？？
            block = ^void(id obj, void* newValue) {
                ((void (*)(id, SEL, void*))imp0)(obj, setSEL, newValue);
                after_did_set(obj, keySEL, newValue);
            };
            break;
        default:
            printf(">>> %s 不支持此类型（包括struct、union）\n", sel_getName(setSEL));
            assert(0);
            break;
    }
    return block;
}


//MARK: -   核心部分

//  关联对象的key
static SEL sel_for_key(const char *name) {
    NSString *getName = [NSString stringWithFormat:@"did_set-%s", name];
    SEL sel = sel_registerName(getName.UTF8String);
    return sel;
}

/**
 首字母大写
 
 @note  调用free释放
 */
static char* upper_first_letter(const char *name) {
    char *s = malloc(sizeof(char) * (strlen(name) + 1));
    strcpy(s, name);
    strcat(s, "\0");
    s[0] = toupper(s[0]);
    return s;
}

//  setter方法名称
static SEL setter_sel(const char *name) {
    char *upperName = upper_first_letter(name);
    
    char *s = malloc(sizeof(char) * (strlen(upperName) + 5));
    strcpy(s, "set");
    strcat(s, upperName);
    strcat(s, ":\0");
    SEL sel = sel_registerName(s);
    free(upperName);
    free(s);
    return sel;
}

//  向原有的setter方法中插入代码
static void class_inset_code(Class cls, const char *name, SEL keySEL) {
    SEL setSEL = setter_sel(name);
    Method m = class_getInstanceMethod(cls, setSEL);
    IMP imp0 = method_getImplementation(m);
    /* id self, SEL op, ... */
    char *types = method_copyArgumentType(m, 2);
    id block = imp_new_block(imp0, setSEL, keySEL, types[0]);
    IMP imp1 = imp_implementationWithBlock(block);
    method_setImplementation(m, imp1);
    free(types);
}

//  obj.key = newValue 调用setter方法时触发
void did_set(id obj, NSString *name, id block) {
    Class cls = object_getClass(obj);
    objc_sync_enter(cls);
    SEL keySEL = sel_for_key(name.UTF8String);
    //  查看该setter方法是否插入过代码片段
    BOOL flag = class_get_bool(cls, keySEL);
    if (flag == NO) {
        class_inset_code(cls, name.UTF8String, keySEL);
        class_set_bool(cls, keySEL, YES);
    }
    //  取出关联的array
    NSMutableArray *array = instance_get_array(obj, keySEL);
    if (array == nil) {
        array = [NSMutableArray new];
        instance_set_array(obj, keySEL, array);
    }
    //  添加到数组中
    [array addObject:block];
    objc_sync_exit(cls);
}
