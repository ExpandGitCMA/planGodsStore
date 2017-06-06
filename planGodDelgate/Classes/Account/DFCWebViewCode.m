//
//  DFCWebViewCode.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/12.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCWebViewCode.h"
#import "DFCStatusUtility.h"
@interface DFCWebViewCode ()<UIWebViewDelegate>
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)UIWebView*webView;
@end

@implementation DFCWebViewCode

-(instancetype)initWithUrl:(NSString*)url{
    
    if(self = [super init]){
        _url=url;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [DFCStatusUtility showActivityIndicator];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate=self;
    NSURL *webViewurl = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:webViewurl];
    [_webView loadRequest:request];
    
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = NO;
    [self.view addSubview:_webView];

}

#pragma mark  UIWebView代理方法-----点击事件
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

//加载结束
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [DFCStatusUtility hideActivityIndicator];

}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [DFCStatusUtility hideActivityIndicator];

}


//开始加载
-(void)webViewDidStartLoad:(UIWebView*)webView {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
