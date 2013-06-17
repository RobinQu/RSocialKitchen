//
//  WeiboAuthViewControllerDelegate.h
//  UNIQUECOMPANYNAME
//
//  Created by Robin Qu on 13-5-2.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SinaWeiboAuthViewController;

@protocol SinaWeiboAuthViewControllerDelegate <NSObject>

- (void)weiboAuthViewController:(SinaWeiboAuthViewController *)authViewController
    didRecieveAuthorizationCode:(NSString *)code;
- (void)weiboAuthViewController:(SinaWeiboAuthViewController *)authViewController
           didFailWithErrorInfo:(NSDictionary *)errorInfo;
- (void)weiboAuthViewControllerDidCancel:(SinaWeiboAuthViewController *)authViewController;

@end
