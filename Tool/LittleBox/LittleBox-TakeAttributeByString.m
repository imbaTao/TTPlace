//
//  LittleBox-TakeAttributeByString.m
//  HZYToolBox
//
//  Created by hong  on 2018/12/19.
//  Copyright © 2018 HZY. All rights reserved.
//

#import "LittleBox-TakeAttributeByString.h"

@implementation LittleBox_TakeAttributeByString
+ (void)takeAttributeByString{

    //获取bundle文件中的图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ContentString.md" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];

    
    NSString *propertyString = @"";
    
//    NSArray *keyArray = [string sege]
    NSMutableArray *keyAndContentArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@","]];
    for (int i = 0; i < keyAndContentArray.count; i++) {
        NSString *oneCompentStr = keyAndContentArray[i];
        NSArray *dicArray = [oneCompentStr componentsSeparatedByString:@":"];;
        if (dicArray.count == 2) {
            // 键的内容
            NSString *keyStr = dicArray[0];
            keyStr = [keyStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            if ([keyStr containsString:@"\n"]) {
                keyStr = [keyStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            }
            if ([keyStr containsString:@" "]) {
                keyStr = [keyStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            
            // 值内容可能带有注释
            NSString *valueStr = dicArray[1];
            
            // 注释
            if ([valueStr containsString:@"\\"]) {
                for (int i = 0; i < valueStr.length; i++) {
                    NSString *temp = [valueStr substringWithRange:NSMakeRange(i, i+1)];
                    if ([temp isEqualToString:@"\\"]) {
                        valueStr = [valueStr substringWithRange:NSMakeRange(i+2, valueStr.length)];
                    }
                }
            }
            
            NSString *newPropertyString = @"";
            // 包含冒号是字符串，否则是integer
            if ([valueStr containsString:@"\""]) {
                newPropertyString = [NSString stringWithFormat:@"\n/** %@ */\n@property(nonatomic,copy)NSString *%@;\n",keyStr,keyStr];
            }else{
                newPropertyString = [NSString stringWithFormat:@"\n/** %@ */\n@property(nonatomic,assign)NSInteger %@;\n",keyStr,keyStr];
            }
            
            propertyString = [NSString stringWithFormat:@"%@%@",propertyString,newPropertyString];
        }
    }
     NSLog(propertyString);
 
}



// 获取建表语句
+ (void)takeWords{
    
    //获取bundle文件中的图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ContentString.md" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];
    
    
    NSString *wordsStr = @"";
    
    //    NSArray *keyArray = [string sege]
    NSMutableArray *keyAndContentArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@";"]];
    
    for (int i = 0; i < keyAndContentArray.count; i++) {
        NSString *tempStr = keyAndContentArray[i];
        if ([tempStr containsString:@"NSString*"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"NSString*" withString:@""];
            tempStr = [tempStr stringByAppendingString:@" text"];
        }else if ([tempStr containsString:@"NSInteger"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"NSInteger" withString:@""];
            tempStr = [tempStr stringByAppendingString:@" integer"];
        }else if ([tempStr containsString:@"BOOL"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"BOOL" withString:@""];
            tempStr = [tempStr stringByAppendingString:@" bool"];
        }else if ([tempStr containsString:@"float"]){
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"float" withString:@""];
            tempStr = [tempStr stringByAppendingString:@" float"];
        }
        wordsStr = [wordsStr stringByAppendingString:[NSString stringWithFormat:@"%@,",tempStr]];
    }
    NSLog(wordsStr);
}



// 填充模型属性
+ (void)takeModelWords{
    
    //获取bundle文件中的图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ContentString.md" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];
    
    NSString *wordsStr = @"";
    
    //    NSArray *keyArray = [string sege]
    NSMutableArray *keyAndContentArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@";"]];
    
    for (int i = 0; i < keyAndContentArray.count; i++) {
        NSString *tempStr = keyAndContentArray[i];
        if ([tempStr containsString:@"NSString*"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"NSString*" withString:@""];
            tempStr = [NSString stringWithFormat:@"model.%@",tempStr];
        }else if ([tempStr containsString:@"NSInteger"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"NSInteger" withString:@""];
            tempStr = [NSString stringWithFormat:@"[NSNumber numberWithInteger:model.%@]",tempStr];
        }else  if ([tempStr containsString:@"BOOL"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"BOOL" withString:@""];
            tempStr = [NSString stringWithFormat:@"[NSNumber numberWithBool:model.%@]",tempStr];
        }else  if ([tempStr containsString:@"float"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"float" withString:@""];
            tempStr = [NSString stringWithFormat:@"[NSNumber numberWithFloat:model.%@]",tempStr];
        }
        wordsStr = [wordsStr stringByAppendingString:[NSString stringWithFormat:@"%@,\n",tempStr]];
    }    NSLog(wordsStr);
}


// 从数据库查询语句
+ (void)takeSearchWords{
    
    //获取bundle文件中的图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ContentString.md" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];
    
    NSString *wordsStr = @"";
    
    //    NSArray *keyArray = [string sege]
    NSMutableArray *keyAndContentArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@";"]];
    
    for (int i = 0; i < keyAndContentArray.count; i++) {
        NSString *tempStr = keyAndContentArray[i];
        if ([tempStr containsString:@"NSString*"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"NSString*" withString:@""];
            tempStr = [NSString stringWithFormat:@"model.%@ = [resultSet stringForColumn:@\"%@\"];",tempStr,tempStr];
        }else if ([tempStr containsString:@"NSInteger"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"NSInteger" withString:@""];
             tempStr = [NSString stringWithFormat:@"model.%@ = [resultSet intForColumn:@\"%@\"];",tempStr,tempStr];
        }else  if ([tempStr containsString:@"BOOL"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"BOOL" withString:@""];
             tempStr = [NSString stringWithFormat:@"model.%@ = [resultSet boolForColumn:@\"%@\"];",tempStr,tempStr];
        }else  if ([tempStr containsString:@"Float"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"Float" withString:@""];
            tempStr = [NSString stringWithFormat:@"model.%@ = [resultSet doubleForColumn:@\"%@\"];",tempStr,tempStr];
        }
        
        wordsStr = [wordsStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",tempStr]];
    }
    NSLog(wordsStr);
}



// 获取复制
+ (void)takeCopyWords{
    
    //获取bundle文件中的图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ContentString.md" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];
    
    NSString *wordsStr = @"";
    
    //    NSArray *keyArray = [string sege]
    NSMutableArray *keyAndContentArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@";"]];
    
    for (int i = 0; i < keyAndContentArray.count; i++) {
        NSString *tempStr = keyAndContentArray[i];
        if ([tempStr containsString:@"\n"]) {
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        }
        
        tempStr = [NSString stringWithFormat:@"recordModel.%@ = model.%@;",tempStr,tempStr];
        
        wordsStr = [NSString stringWithFormat:@"%@\n%@",wordsStr,tempStr];
    }
    NSLog(wordsStr);
}
@end
