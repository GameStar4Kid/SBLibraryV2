//
//  BuyTool.h
//  LittleWall
//
//  Created by caoyusheng on 8/5/17.
//  Copyright © 2017年 caoyusheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "SubscriptionData.h"

typedef void(^AfterQuery)();

typedef void(^AfterVerify)(NSInteger status);

@interface BuyTool : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL tryNow;

+ (instancetype) sharedInstance;

- (void)activeSB:(UIViewController*)ctrl;

- (void)activeSB2:(UIViewController*)ctrl;

- (UIViewController*)showActiveSB2:(UIViewController*)ctrl completion:(void (^)(void))completion;

- (UIViewController*)showActiveSBTrial:(UIViewController*)ctrl isSkip:(BOOL)isSkip completion:(void (^)(void))completion;

- (UIViewController*)showInternalWebView:(UIViewController*)ctrl url:(NSString*)url title:(NSString*)title completion:(void (^)(void))completion;

- (void)initShop;

- (void)stopShop;

- (void)queryAllProducts: (UIViewController *) controller after:(AfterQuery)after;

- (SubscriptionData *) getBuyDataWithProductIdentifier: (NSString *)productIdentifier;

- (NSInteger) getProductsCount;

- (void)buyInShop:(SubscriptionData *)data controller:(UIViewController *) controller;

- (void)restore: (UIViewController *) controller;

- (NSMutableArray <SubscriptionData *> *) getProducts;

- (NSArray<SubscriptionData*>*)getSubsProducts;

- (NSArray<SubscriptionData*>*)getNonConsProducts;

- (BOOL) isLoadingProducts;

- (void) verifyReceipt;

- (void) verifyReceipt: (UIViewController *) controller after:(AfterVerify)after;

- (void) showSubscriptionScreen:(UIViewController *) controller;

+ (NSString *) getCongfigInFile: (NSString *)key;
@end

//沙盒测试环境验证
#define Env_Sandbox @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define Env_AppStore @"https://buy.itunes.apple.com/verifyReceipt"

#define FINISH_PURCHAED_RESTORED @"FINISH_PURCHAED_RESTORED"
