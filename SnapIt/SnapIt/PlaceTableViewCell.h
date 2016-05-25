//
//  PlaceCellTableViewCell.h
//  SnapIt
//
//  Created by Admin on 25.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailLabel;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;

@end
