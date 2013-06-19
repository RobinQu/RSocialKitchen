//
//  OAuthData.h
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-19.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const WeiboOAuthDataLabel = @"weibo";

static NSString *const OAuthAccessTokenKey = @"AccessTokenKey";
static NSString *const OAuthExpirationDateKey = @"ExpirationDateKey";
static NSString *const OAuthUserIDKey = @"UserIDKey";
static NSString *const OAuthRefreshTokenKey = @"RefreshTokenKey";

@interface OAuthData : NSObject

@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *refreshToken;
@property (nonatomic, retain) NSDate *expirationDate;
@property (nonatomic, retain) NSString *userID;


+ (id)readAuthDataWithLabel:(NSString *)label;
+ (void)clearAuthDataWithLabel:(NSString *)label;


- (id)initWithAccessToken:(NSString *)accessToken
           expirationDate:(NSDate *)expirationDate
             refreshToken:(NSString *)refreshToken
                   userID:(NSString *)userID;

- (void)storeForLabel:(NSString *)label;

@end
