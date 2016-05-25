//
//  PlaceCellTableViewCell.m
//  SnapIt
//
//  Created by Admin on 25.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize detailLabel = _detailLabel;
@synthesize photoImageView = _photoImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
