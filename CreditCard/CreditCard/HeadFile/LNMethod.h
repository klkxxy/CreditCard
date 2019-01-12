//
//  LNMethod.h
//  LilacNight
//
//  Created by LilacNight on 2018/7/30.
//  Copyright © 2018年 PC. All rights reserved.
//

#ifndef LNMethod_h
#define LNMethod_h
#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

#define ArchiveCode \
static NSMutableArray *ivars;\
+(void)load{\
ivars = [NSMutableArray array];\
unsigned int numIvars;\
Ivar *vars = class_copyIvarList(self, &numIvars);\
for(int i = 0; i < numIvars; i++) {\
Ivar thisIvar = vars[i];\
NSString *name = [NSString stringWithUTF8String:ivar_getName(thisIvar)];\
NSString *key = [name substringFromIndex:1];\
[ivars addObject:key];\
}\
free(vars);\
}\
- (void)encodeWithCoder:(NSCoder *)enCoder{\
for (NSString *propertyName in ivars) {\
SEL getSel = NSSelectorFromString(propertyName);\
[enCoder encodeObject:[self performSelector:getSel] forKey:propertyName];\
}\
}\
- (id)initWithCoder:(NSCoder *)aDecoder{\
for (NSString *propertyName in ivars) {\
NSString *firstCharater = [propertyName substringToIndex:1].uppercaseString;\
NSString *setPropertyName = [NSString stringWithFormat:@"set%@%@:",firstCharater,[propertyName substringFromIndex:1]];\
SEL setSel = NSSelectorFromString(setPropertyName);\
[self performSelector:setSel withObject:[aDecoder decodeObjectForKey:propertyName]];\
}\
return  self;\
}

//云信使用
#define NTES_USE_CLEAR_BAR - (BOOL)useClearBar{return YES;}

#define NTES_FORBID_INTERACTIVE_POP - (BOOL)forbidInteractivePop{return YES;}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define GOLD_NAME(userType) (userType == 1)?@"话币":@"钻石"


#endif /* LNMethod_h */
