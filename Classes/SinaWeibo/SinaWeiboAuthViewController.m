//
//  SinaWeiboAuthViewController.m
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-17.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import "SinaWeiboAuthViewController.h"
#import "SinaWeiboConstants.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "SinaWeibo.h"


UIViewController* findTopMostVC()
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

@interface SinaWeiboAuthViewController ()

@property (nonatomic, retain) SinaWeibo *sinaweibo;
@property (nonatomic, assign, readonly) NSString *apiKey;
@property (nonatomic, assign, readonly) NSString *apiSecret;
@property (nonatomic, assign, readonly) NSString *redirectURL;

@end

@implementation SinaWeiboAuthViewController

@synthesize webView = _webView;

+ (id)sharedAuthViewController
{
    static SinaWeiboAuthViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *fp = [[NSBundle mainBundle] pathForResource:@"weibo" ofType:@"plist"];
        NSDictionary *p = nil;
        if (fp) {
            p = [[NSDictionary alloc] initWithContentsOfFile:fp];
        } else {
            p = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"Weibo"];
        }
        NSAssert(p, @"Configration file weibo.plist is missing");
        vc = [[SinaWeiboAuthViewController alloc] initWithParameters:p];
    });
    return vc;
}

+ (void)configureSharedDelegate:(id<SinaWeiboDelegate, RWebBrowserDelegate>)delegate
{
    SinaWeiboAuthViewController *vc = [self sharedAuthViewController];
    vc.sinaweibo.delegate = delegate;
    vc.delegate = delegate;
//
//    //for auth view vc, its webview delegate must be itself
//    vc.webView = nil;
//    vc.webView.delegate = vc;
    NSLog(@"config delegate %@", delegate);
}


- (id)initWithParameters:(NSDictionary *)parameters delegate:(id<SinaWeiboDelegate>)delegate
{
    self = [self initWithParameters:parameters];
    if (self) {
        self.sinaweibo.delegate = delegate;
    }
    return self;
}

- (id)initWithParameters:(NSDictionary *)parameters
{
    self = [super initWithParameters:parameters];
    if (self) {
        self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:self.apiKey appSecret:self.apiSecret appRedirectURI:self.redirectURL andDelegate:nil];
        self.sinaweibo.authVC = self;
    }
    return self;
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[self frameForMainContent]];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SinaWeibo Auth";
}

- (NSString *)apiKey
{
    return [self.parameters valueForKey:@"key"];
}

- (NSString *)apiSecret
{
    return [self.parameters valueForKey:@"secret"];
}

- (NSString *)redirectURL
{
    return [self.parameters valueForKey:@"redirect"];
}

- (BOOL)isAuthenticated
{
    return [self.sinaweibo isAuthValid];
}

- (void)requestAuth
{
    [self.sinaweibo logIn];
    
}

- (void)logout
{
    [self.sinaweibo logOut];
}

- (void)openAuthDialog
{
     [findTopMostVC() presentViewController:self animated:YES completion:nil];
}

- (void)closeAuthDialog
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView Delegate
- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    NSString *siteRedirectURI = [NSString stringWithFormat:@"%@%@", kSinaWeiboSDKOAuth2APIDomain, self.redirectURL];
    if ([url hasPrefix:self.redirectURL] || [url hasPrefix:siteRedirectURI])
    {
        NSString *error_code = [SinaWeiboRequest getParamValueFromUrl:url paramName:@"error_code"];
        
        if (error_code)
        {
            NSString *error = [SinaWeiboRequest getParamValueFromUrl:url paramName:@"error"];
            NSString *error_uri = [SinaWeiboRequest getParamValueFromUrl:url paramName:@"error_uri"];
            NSString *error_description = [SinaWeiboRequest getParamValueFromUrl:url paramName:@"error_description"];
            
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       error, @"error",
                                       error_uri, @"error_uri",
                                       error_code, @"error_code",
                                       error_description, @"error_description", nil];
            
            [self closeAuthDialog];
            [self.sinaweibo weiboAuthViewController:self didFailWithErrorInfo:errorInfo];
        }
        else
        {
            NSString *code = [SinaWeiboRequest getParamValueFromUrl:url paramName:@"code"];
            if (code)
            {
                [self closeAuthDialog];
                [self.sinaweibo weiboAuthViewController:self didRecieveAuthorizationCode:code];
            }
        }
        
        return NO;
    }
    
    return YES;
}

- (void)dialogDidCloseByUser
{
    [self cancel];
}

- (void)cancel
{
    [self.sinaweibo weiboAuthViewControllerDidCancel:self];
}


@end
