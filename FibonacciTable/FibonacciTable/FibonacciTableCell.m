//
//  FibonacciTableCell.m
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import "FibonacciTableCell.h"

@implementation FibonacciTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.indexLabel = [UILabel new];
        [self setupLabel:self.indexLabel multiplierWidth:0.2];
        self.indexLabel.backgroundColor = [UIColor lightGrayColor];
        
        
        self.valueLabel = [UILabel new];
        [self setupLabel:self.valueLabel multiplierWidth:0.8];
        self.valueLabel.backgroundColor = [UIColor grayColor];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[_indexLabel]-(0)-[_valueLabel]-(0)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_indexLabel, _valueLabel)]];
    }
    return self;
}

- (void)setupLabel:(UILabel *)label multiplierWidth:(CGFloat)multiplierWidth {
    
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    label.numberOfLines = 50;
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(label)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:multiplierWidth
                                                      constant:0]];
}

@end
