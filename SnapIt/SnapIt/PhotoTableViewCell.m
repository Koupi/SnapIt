//
//  PhotoTableViewCell.m
//  SnapIt
//
//  Created by Admin on 25.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell

@synthesize photoImageView = _photoImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
