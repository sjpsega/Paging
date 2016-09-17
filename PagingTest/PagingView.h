//
//  PagingView.h
//  PagingTest
//
//  Created by sjpsega on 16/7/15.
//  Copyright © 2016年 sjpsega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagingView : UIScrollView

@property(nonatomic, assign, readonly)NSUInteger currentPage;

- (void)addNeedPagingView:(UIView *)view;
- (void)turnNext;
- (void)turnPre;

@end
