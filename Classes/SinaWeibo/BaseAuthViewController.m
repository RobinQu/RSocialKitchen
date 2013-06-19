//
//  BaseAuthViewController.m
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import "BaseAuthViewController.h"

@interface BaseAuthViewController ()

@end

@implementation BaseAuthViewController

- (id)initWithParameters:(NSDictionary *)parameters
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.parameters = parameters;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
        _webView.frame = [self frameForMainContent];
    }
    return _webView;
}

- (void)loadURL:(NSURL *)url
{
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)requestAuth
{
    NSAssert([self isKindOfClass:[BaseAuthViewController class]], @"should not be invoke on a base class");
}

- (BOOL)isAuthenticated
{
    NSAssert([self isKindOfClass:[BaseAuthViewController class]], @"should not be invoke on a base class");
    return NO;
}

- (void)cancel
{
    NSAssert([self isKindOfClass:[BaseAuthViewController class]], @"should not be invoke on a base class");
}

- (void)logout
{
    NSAssert([self isKindOfClass:[BaseAuthViewController class]], @"should not be invoke on a base class");
}

- (void)openAuthDialog
{
    NSAssert([self isKindOfClass:[BaseAuthViewController class]], @"should not be invoke on a base class");
}

- (void)closeAuthDialog
{
    NSAssert([self isKindOfClass:[BaseAuthViewController class]], @"should not be invoke on a base class");
}

@end
