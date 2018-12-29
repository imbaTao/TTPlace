//
//  Student+CoreDataProperties.h
//  HZYToolBox
//
//  Created by hong  on 2018/12/29.
//  Copyright © 2018 HZY. All rights reserved.
//

#import "Student+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student(CoreDataProperties)
+ (NSFetchRequest<Student *> *)fetchRequest;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nonatomic) int16_t age;
@property (nonatomic) int16_t height;
@property (nonatomic) int16_t number;
@end

NS_ASSUME_NONNULL_END
