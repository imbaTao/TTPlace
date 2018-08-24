//
//  NSCodingLearnMethod.h
//  HZYToolBox
//
//  Created by hong  on 2018/8/21.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCodingLearnMethod : NSObject<NSCoding>
/** name */
@property(nonatomic,copy)NSString *name;

/** ID */
@property(nonatomic,assign)int ID;

- (instancetype)initWithName:(NSString *)name ID:(int)ID;
@end
