//
//  ScrollingTableView.h
//  FibonacciTable
//
//  Created Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigNumber.h"

@protocol ScrollingTableViewDelegate;

@interface ScrollingTableView : UIView

@property (assign, nonatomic) NSInteger rowsPerScreen;
@property (assign, nonatomic) NSInteger loadedScreens;

@property (weak, nonatomic) id<ScrollingTableViewDelegate> delegate;
@end


@protocol ScrollingTableViewDelegate <NSObject>

- (BigNumber *)valueForScrollingTableView:(ScrollingTableView *)scrollingTableView atIndex:(NSInteger)index;
@end
