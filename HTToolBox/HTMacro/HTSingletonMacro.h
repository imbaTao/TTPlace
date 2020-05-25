//
//  HTSingletonMacro.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/13.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#ifndef HTSingletonMacro_h
#define HTSingletonMacro_h

#define singleH(name) +(instancetype)share##name;
#if __has_feature(objc_arc)
#define singleM(name) static id _instance;\
static dispatch_once_t onceToken;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#else
#define singleM static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shareTools\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif
#endif /* HTSingletonMacro_h */
