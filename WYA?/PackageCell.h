//
//  PackageCell.h
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *packagePicture;
@property (weak, nonatomic) IBOutlet UILabel *packageTitle;

@end

NS_ASSUME_NONNULL_END
