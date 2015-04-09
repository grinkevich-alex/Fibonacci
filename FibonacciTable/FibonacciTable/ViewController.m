//
//  ViewController.m
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import "ViewController.h"

#import "ScrollingTableView.h"
#import "FibonacciValueGenerator.h"
#import "BigNumber.h"

static NSInteger const kRowsPerScreen = 4;
static NSInteger const kLoadedScreens = 3;

@interface ViewController () <ScrollingTableViewDelegate>
@property (strong, nonatomic) ScrollingTableView *tableView;
@property (strong, nonatomic) FibonacciValueGenerator *fibonacciValueGenerator;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fibonacciValueGenerator = [FibonacciValueGenerator new];
    
    self.tableView = [ScrollingTableView new];
    self.tableView.rowsPerScreen = kRowsPerScreen;
    self.tableView.loadedScreens = kLoadedScreens;
    self.tableView.delegate = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                 options:0
                                                                 metrics:0
                                                                   views:NSDictionaryOfVariableBindings(_tableView)]];
}

#pragma mark - ScrollingTableViewDelegate

- (NSString *)valueForScrollingTableView:(ScrollingTableView *)scrollingTableView atIndex:(NSInteger)index {
    NSString *indexString = @(index).stringValue;
    BigNumber *indexBigNumber = [[BigNumber alloc] initWithStringRepresentation:indexString];
    NSString *valueString = [self.fibonacciValueGenerator fibonacciValueForIndex:indexBigNumber].stringValue;
    return valueString;
}

@end
