//
//  NSObject+HZYEnumerate.h
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/13.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HZYEnumerate)


/**
 为签到设立的枚举
 */
typedef NS_ENUM(NSInteger, ATTStatus){
    StatusStop = -1, // 停课
    StatusDefault,// 默认
    StatusArrive,// 到
    StatusNoArrive,// 缺
    StatusLeaveEarly, // 退
    StatusSick,// 病
    StatusSomething, // 事
    StatusLate,// 迟
};


/**
 为考勤类型设置枚举
 */
typedef NS_ENUM(NSInteger, AttendanceType){
    Manager_times_te = 0, // 次数考勤老师端
    Manager_week_te, // 周考勤老师端
    Activity_kwfd_te, // 课外辅导课考勤老师端
    Activity_kwfd_st, // 课外辅导课考勤学生端
    Activity_gms_te, // 竞赛老师端
    Activity_gms_st, // 竞赛学生端
    Activity_cts_te, // 集训老师端
    Activity_cts_st, // 集训学生端
    Student_signIn, // 学生端签到
    Student_signOut, // 学生端签到
    Student_signInEnd, // 学生端考勤结束
    Student_signOutEnd, // 学生端考勤结束
};

@end

NS_ASSUME_NONNULL_END
