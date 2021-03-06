//
//  WebController.m
//  Vpn1
//
//  Created by caoyusheng on 3/7/17.
//  Copyright © 2017年 caoyusheng. All rights reserved.
//

#import "WebController.h"
#import "View+MASAdditions.h"
#import "BuyTool.h"
@import WebKit;
@interface WebController () <WKUIDelegate>

@property (strong, nonatomic) IBOutlet WKWebView *webview;

@end

@implementation WebController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initWebView];
    
    self.title = _titleKey;
}

- (void)initWebView
{
    _webview = [[WKWebView alloc] initWithFrame: self.view.frame];
    _webview.UIDelegate = self;
    
    [self.view addSubview:_webview];
    
    [_webview loadRequest:[NSURLRequest requestWithURL:[self getWebUrl]]];
    UIImageView *setImgView = [[UIImageView alloc]init];
    //setImgView.frame = CGRectMake(SWidth-35, 25, 25, 25);
    setImgView.image = [UIImage imageNamed:@"iap-close"];
    setImgView.userInteractionEnabled = YES;
    [self.view addSubview:setImgView];
    [setImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@(35));
        make.right.equalTo(@(-20));
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
    [setImgView addGestureRecognizer:singleTap];
}

- (NSURL *)getWebUrl
{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:_url ofType:@"html"];
    NSURL *htmlUrl = [NSURL fileURLWithPath:htmlPath];
    return htmlUrl;
}

- (void) webviewGoback{
    if ([_webview canGoBack]) {
        [_webview goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)closeAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view removeFromSuperview];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURLRequest *request = navigationAction.request;
    NSString *url = [[request URL]absoluteString];
    if([url containsString:@"restorePurchase"])
    {
        [[BuyTool sharedInstance] restore:self ];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
@end
