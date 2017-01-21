//
//  UNManager.m
//  Keeping
//
//  Created by 宋 奎熹 on 2017/1/20.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "UNManager.h"
#import "DateTools.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation UNManager

//定时推送
+ (void)createLocalizedUserNotification:(Task *)task{
    // 设置触发条件 UNNotificationTrigger
    for(NSNumber *weekday in task.reminderDays){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.weekday = [weekday integerValue];
        
        
        components.hour = task.reminderTime.hour;
        components.minute = task.reminderTime.minute;
        
        
//        components.hour = [[NSDate date] hour];
//        components.minute = [[[NSDate date] dateByAddingMinutes:1] minute];
        
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        
        // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = task.name;
        content.subtitle = @"";
        
        if(task.appScheme != NULL){
            content.body = [NSString stringWithFormat:@"前往→%@", task.appScheme.allKeys[0]];
        }else{
            content.body = @"就是现在!";
        }
        
        content.badge = @1;
        content.sound = [UNNotificationSound defaultSound];
        content.userInfo = @{};
        
        // 创建通知标示
        NSString *requestIdentifier = [NSString stringWithFormat:@"unid%@%@",task.addDate.description,weekday];
        // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        // 将通知请求 add 到 UNUserNotificationCenter
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                NSLog(@"推送已添加成功 %@", requestIdentifier);
            }
        }];
    }
}

+ (void)deleteLocalizedUserNotification:(Task *)task{
    for(NSNumber *weekday in task.reminderDays){
        // 创建通知标示
        NSString *requestIdentifier = [NSString stringWithFormat:@"unid%@%@",task.addDate.description,weekday];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removePendingNotificationRequestsWithIdentifiers:@[requestIdentifier]];
        NSLog(@"删除通知");
    }
}

@end
