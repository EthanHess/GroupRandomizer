//
//  CollectionViewCell.m
//  groupRandomizer
//
//  Created by Ethan Hess on 5/29/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@property (nonatomic,assign) CGRect frame;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.frame = frame;
    
    if (self) {
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.nameLabel.layer.cornerRadius = self.frame.size.height / 2;
        self.nameLabel.backgroundColor = [UIColor blueColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont fontWithName:@"Chalkduster" size:12];
        self.nameLabel.layer.masksToBounds = YES;
        self.nameLabel.layer.borderWidth = 3.0;
        self.nameLabel.layer.borderColor = [[UIColor whiteColor]CGColor]; 
        [self addSubview:self.nameLabel];

    }
    
    return self;
    
}



@end
