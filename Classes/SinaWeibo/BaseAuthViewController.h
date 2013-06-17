//
//  BaseAuthViewController.h
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewController.h"

@interface BaseAuthViewController : ModalViewController <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSDictionary *parameters;

- (id)initWithParameters:(NSDictionary *)parameters;

- (void)openAuthDialog;
- (void)closeAuthDialog;


- (void)requestAuth;
- (void)logout;
- (void)loadURL:(NSURL *)url;
- (BOOL)isAuthenticated;
- (void)cancel;

@end