//
//  NSCodingLearnMethod.m
//  HZYToolBox
//
//  Created by hong  on 2018/8/21.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "NSCodingLearnMethod.h"

@implementation NSCodingLearnMethod
- (instancetype)initWithName:(NSString *)name ID:(int)ID
{
    self = [super init];
    if (self) {
        self.name = name;
        self.ID = ID;
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:[NSNumber numberWithInt:self.ID] forKey:@"iD"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.ID = [[coder decodeObjectForKey:@"ID"] intValue];
    }
    return self;
}



@end
