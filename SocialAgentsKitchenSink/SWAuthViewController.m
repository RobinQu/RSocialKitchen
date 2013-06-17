//
//  SWAuthViewController.m
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import "SWAuthViewController.h"
#import "SinaWeiboAuthViewController.h"

@interface SWAuthViewController ()

@property (nonatomic, retain) SinaWeiboAuthViewController *authVC;

@end

@implementation SWAuthViewController

+ (id)defaultAuthViewController
{
    NSString *fp = [[NSBundle mainBundle] pathForResource:@"weibo" ofType:@"plist"];
    NSDictionary *p = [[NSDictionary alloc] initWithContentsOfFile:fp];
    SinaWeiboAuthViewController *authVC = [[SinaWeiboAuthViewController alloc] initWithParameters:p];
    SWAuthViewController *avc = [[SWAuthViewController alloc] initWithRootViewController:authVC];
    avc.authVC = authVC;
    return avc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(didTapOnCancel)];
}

- (void)didTapOnCancel
{
    [self.authVC cancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    //1. clean the auth data
    //2. prompt for auth, again
    //3. show this vc, if necessary
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.authVC requestAuth];
}

@end
