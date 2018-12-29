//
//  Student+CoreDataProperties.m
//  HZYToolBox
//
//  Created by hong  on 2018/12/29.
//  Copyright © 2018 HZY. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic sex;
@dynamic age;
@dynamic height;
@dynamic number;
@end
