//
//  PackageCell.h
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carrier;
@property (weak, nonatomic) IBOutlet UILabel *deliveryDate;
@property (weak, nonatomic) IBOutlet UILabel *deliveryMessage;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *trackingNumber;
@end

NS_ASSUME_NONNULL_END
