//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <Foundation/Foundation.h>
#import "APIError.h"

#define CACHE_TIME 7*86400 // In seconds

@interface APICaller : NSObject {
    id delegate;
    NSMutableData *urlData;
    NSURLConnection *connection;
    NSString *reqJSON;
    NSMutableString *url;
    int lastStatusCode;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableData *urlData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSString *reqJSON;
@property (nonatomic, retain) NSMutableString *url;
@property (nonatomic, assign) int lastStatusCode;

- (id)initWithDelegate:(id)_delegate;
- (NSString *)getApiUrl;
- (void)callAPI:(NSString *)type method:(NSString *)method params:(NSDictionary *)params needAuth:(BOOL)needAuth;
- (void)callAPI:(NSString *)type method:(NSString *)method params:(NSDictionary *)params needAuth:(BOOL)needAuth canCache:(BOOL)canCache;
- (void)callAPI:(NSString *)type needAuth:(BOOL)needAuth canCache:(BOOL)canCache;
- (void)callAPI:(NSString *)type params:(NSDictionary *)params needAuth:(BOOL)needAuth;
- (void)callAPI:(NSString *)type params:(NSDictionary *)params needAuth:(BOOL)needAuth canCache:(BOOL)canCache;
- (void)callAPI:(NSString *)type needAuth:(BOOL)needAuth;
- (void)cancel;
- (void)gotResponse:(NSString *)responseString;
- (BOOL)checkCacheForRequest:(NSString *)_reqJSON toUrl:(NSString *)url ignoreExpiry:(BOOL)ignoreExpiry;
- (void)writeDataToCache:(NSString *)responseData requestJSON:(NSString *)_reqJSON toUrl:(NSString *)_url;

+ (void)clearCache;

// Override these methods to implement a new API call
- (void)call:(NSString *)eventType;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end
