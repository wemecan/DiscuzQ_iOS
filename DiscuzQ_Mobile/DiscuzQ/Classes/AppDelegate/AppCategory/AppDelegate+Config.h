//
//  DZQDelegate+Config.h
//  DiscuzQ
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 WebersonGao. All rights reserved.
//  真正的全局配置数据

#import "DZQDelegate.h"
#import "AppDelegate+SDK.h"
#import "AppDelegate+Launch.h"
#import "AppDelegate+Global.h"
#import "AppDelegate+Update.h"

@interface DZQDelegate (Config)

- (BOOL)isFirstInstall;

-(void)Config_WhenAppDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;




@end

