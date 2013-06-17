//
//  ViewController.h
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface ViewController : UIViewController <SinaWeiboDelegate>

- (IBAction)authForSinaweibo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *weiboAuthButton;

@end
