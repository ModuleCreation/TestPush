//
//  TPPush.h
//  testPush
//
//  Created by tangpeng on 2018/1/23.
//Copyright © 2018年 TPQuietBro. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TPPush : NSObject<UIApplicationDelegate>
@property (nonatomic,strong) NSDictionary *userInfo;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end
