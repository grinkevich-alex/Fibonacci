//
//  ScrollingTableView.m
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import "ScrollingTableView.h"

#import "FibonacciTableCell.h"


@interface ScrollingTableView () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger pageIndex;          // we could declare .pageIndex as BigNumber but we need to add more operations to that class
@property (nonatomic, assign) CGFloat lastContentOffsetY;
@property (nonatomic, assign) NSArray *indexes;
@end

@implementation ScrollingTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tableView = [UITableView new];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.pagingEnabled = YES;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.allowsSelection = NO;
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.tableView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_tableView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_tableView)]];
    }
    return self;
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return floorf(self.bounds.size.height/self.rowsPerScreen);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loadedScreens * self.rowsPerScreen;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"FibonacciTableCellID";
    FibonacciTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[FibonacciTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    NSInteger startIndex = (self.loadedScreens - 2)*self.pageIndex*self.rowsPerScreen;
    NSInteger index = startIndex + indexPath.row;
    cell.indexLabel.text = @(index).stringValue;
    cell.valueLabel.text = [self.delegate valueForScrollingTableView:self atIndex:index];
    return cell;
}

#pragma mark -

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrollView.userInteractionEnabled = YES;
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    if (self.lastContentOffsetY == contentOffsetY) {
        return;
    }
    
    CGFloat tableHeight= self.tableView.frame.size.height;
    
    NSInteger direction = 1;
    if (contentOffsetY == 0.0) {
        direction = -1;
    }
    
    self.pageIndex += direction;
    if (self.pageIndex > 0) {
        self.tableView.contentOffset = CGPointMake(0, tableHeight); // scrolling to the middle of table view
        self.lastContentOffsetY = tableHeight;
    } else {
        self.lastContentOffsetY = contentOffsetY;
    }
    [self.tableView reloadData];
}

@end
