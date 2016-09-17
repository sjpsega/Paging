//
//  ViewController.m
//  PagingTest
//
//  Created by sjpsega on 16/7/15.
//  Copyright © 2016年 sjpsega. All rights reserved.
//

#import "ViewController.h"
#import "PagingView.h"

static const CGFloat threshold = 50;

@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic)PagingView *pageView;

@end

@implementation ViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pageView = [[PagingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.pageView];
    
    UIWebView *webView1 = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.pageView addNeedPagingView:webView1];
    [webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.lianjia.com"]]];
    
    UIWebView *webView2 = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.pageView addNeedPagingView:webView2];
   [webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.lianjia.com"]]];
    
    //set delegate
    webView1.scrollView.delegate = self;
    webView2.scrollView.delegate = self;
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"Next" forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor redColor]];
    [_button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    _button.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:_button];
    
    UIButton *_button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setTitle:@"Pre" forState:UIControlStateNormal];
    [_button2 setBackgroundColor:[UIColor greenColor]];
    [_button2 addTarget:self action:@selector(preAction:) forControlEvents:UIControlEventTouchUpInside];
    _button2.frame = CGRectMake(0, 80, 50, 50);
    [self.view addSubview:_button2];
}

- (void)nextAction:(id)sender{
    [_pageView turnNext];
}

- (void)preAction:(id)sender{
    [_pageView turnPre];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - implement UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if([self isPullUpWithScrollView:scrollView]){
        [_pageView turnPre];
    }
    if([self isPullDownWithScrollView:scrollView]){
        [_pageView turnNext];
    }
}

#pragma mark - util
- (BOOL)isPullUpWithScrollView:(UIScrollView *)scrollView{
    return scrollView.contentOffset.y < -threshold;
}

- (BOOL)isPullDownWithScrollView:(UIScrollView *)scrollView{
    return [self contentOffsetBottom:scrollView] > threshold;
}

- (CGFloat)contentOffsetBottom:(UIScrollView*)scrollView
{
    return scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height + scrollView.contentInset.bottom);
}
@end
