//
//  ViewController.m
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import "ViewController.h"
#import "SinaWeiboAuthViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController ()

@property (nonatomic, retain) SinaWeiboAuthViewController* sinaWeiboAuthVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Social Kitchen Sink";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateButtons];
}

- (void)updateButtons
{
    NSString *btnLabel = self.sinaWeiboAuthVC.isAuthenticated ? @"Logout Weibo" : @"Login Weibo";
    [self.weiboAuthButton setTitle:btnLabel forState:UIControlStateNormal];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SinaWeiboAuthViewController *)sinaWeiboAuthVC
{
    if (!_sinaWeiboAuthVC) {
        [SinaWeiboAuthViewController configureSharedDelegate:self];
        _sinaWeiboAuthVC = [SinaWeiboAuthViewController sharedAuthViewController];
    }
    return _sinaWeiboAuthVC;
}

- (IBAction)authForSinaweibo:(id)sender {
    if (self.sinaWeiboAuthVC.isAuthenticated) {
        [self.sinaWeiboAuthVC logout];
        [self updateButtons];
    } else {
        [self.sinaWeiboAuthVC requestAuth];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateButtons];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"Authentication Expired"];
    [self presentViewController:self.sinaWeiboAuthVC animated:YES completion:nil];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"Login failed"];
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [SVProgressHUD showSuccessWithStatus:@"Login successfully"];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    [SVProgressHUD showSuccessWithStatus:@"Logout successfully"];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    [SVProgressHUD showErrorWithStatus:@"Authentication cancelled"];
}

@end
