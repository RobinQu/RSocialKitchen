//
//  SinaWeiboAuthViewController.h
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAuthViewController.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"

@interface SinaWeiboAuthViewController : BaseAuthViewController

- (id)initWithParameters:(NSDictionary *)parameters delegate:(id<SinaWeiboDelegate>)delegate;


@end
