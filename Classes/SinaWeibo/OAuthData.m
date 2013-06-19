//
//  OAuthData.m
//  SocialAgentsKitchenSink
//
//  Created by Robin Qu on 13-6-19.
//  Copyright (c) 2013年 Robin Qu. All rights reserved.
//

#import "OAuthData.h"

@interface OAuthData ()



@end

@implementation OAuthData


+ (id)readAuthDataWithLabel:(NSString *)label
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [defaults objectForKey:label];
    OAuthData *data = nil;
    //we don't check refresh token because not all service provide refresh tokens
    if (info && [info objectForKey:OAuthAccessTokenKey] && [info valueForKey:OAuthExpirationDateKey] && [info valueForKey:OAuthUserIDKey])
    {
        data = [[OAuthData alloc] initWithAccessToken:[info objectForKey:OAuthAccessTokenKey] expirationDate:[info objectForKey:OAuthExpirationDateKey] refreshToken:[info valueForKey:OAuthRefreshTokenKey] userID:[info objectForKey:OAuthUserIDKey]];
    }
    return data;
}

+ (void)clearAuthDataWithLabel:(NSString *)label
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:label];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)initWithAccessToken:(NSString *)accessToken expirationDate:(NSDate *)expirationDate refreshToken:(NSString *)refreshToken userID:(NSString *)userID
{
    self = [self init];
    if (self) {
        self.accessToken = accessToken;
        self.refreshToken = refreshToken;
        self.userID = userID;
        self.expirationDate = expirationDate;
    }
    return self;
}

- (void)storeForLabel:(NSString *)label
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.accessToken, OAuthAccessTokenKey,
                          self.expirationDate, OAuthExpirationDateKey,
                          self.userID, OAuthUserIDKey,
                          self.refreshToken, OAuthRefreshTokenKey, nil];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:label];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
