//
//  PagingView.m
//  PagingTest
//
//  Created by sjpsega on 16/7/15.
//  Copyright © 2016年 sjpsega. All rights reserved.
//

#import "PagingView.h"
@interface PagingView()<UIScrollViewDelegate>

@end

@implementation PagingView{
    NSMutableArray *_pagingViews;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _pagingViews = [@[] mutableCopy];
        self.scrollEnabled = NO;
        self.directionalLockEnabled  = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        
        self.delaysContentTouches = YES;
        self.canCancelContentTouches = YES;
        self.clipsToBounds = YES;
        
        _currentPage = 0;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_pagingViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = CGRectMake(0, CGRectGetHeight(self.frame) * idx, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }];
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * _pagingViews.count);
}

- (void)addNeedPagingView:(UIView *)view{
    [_pagingViews addObject:view];
    [self addSubview:view];
}

- (NSUInteger)pageCount{
    return [_pagingViews count];
}

- (void)turnNext{
    if(_currentPage < (self.pageCount - 1)){
        _currentPage++;
        [self scrollRectToVisible:CGRectMake(0, CGRectGetHeight(self.frame) * _currentPage, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];
    }
}

- (void)turnPre{
    if(_currentPage > 0){
        _currentPage--;
        [self scrollRectToVisible:CGRectMake(0, CGRectGetHeight(self.frame) * _currentPage, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];
    }
}
@end
