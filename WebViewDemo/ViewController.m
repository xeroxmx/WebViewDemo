//
//  ViewController.m
//  WebViewDemo
//
//  Created by chenbowen on 2017/6/27.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "ViewController.h"
#import "DDProgressView.h"


@interface ViewController ()<UIWebViewDelegate>
@property(strong,nonatomic)DDProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    self.navigationItem.title = @"api/cookies/read";

    self.webView.delegate = self;

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSString *url = @"https://gatewaytest.qianduan.com/api/cookies/read";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
}

- (IBAction)reload:(UIBarButtonItem *)sender {
    
    [self.webView reload];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
     [self.progressView startColorful];
    
    return  YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (self.progressView.superview == nil) {
        UINavigationController *nav = self.navigationController;
        [nav.view addSubview:self.progressView];
    }
    [self.progressView startColorful];
    [self.progressView setProgress:0.9 duation:2 animated:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.progressView setProgress:1.0];
    [self performSelector:@selector(removeLoadingView) withObject:nil afterDelay:0.5f];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark - 进度条停止
-(void)removeLoadingView{
    [self.progressView stopColorful];
}


-(DDProgressView *)progressView{
    
    if (_progressView == nil) {

            _progressView = [[DDProgressView alloc] initWithFrame:(CGRect){0,64,[UIScreen mainScreen].bounds.size.width,2} backGroundColor:[UIColor blueColor]];
            
            UINavigationController *nav = self.navigationController;
            [nav.view addSubview:_progressView];
    
    }
    return _progressView;
}


@end
