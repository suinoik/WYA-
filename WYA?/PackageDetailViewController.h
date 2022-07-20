//
//  PackageDetailViewController.h
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *carrier;
@property (weak, nonatomic) IBOutlet UILabel *deliveryDate;
@property (weak, nonatomic) IBOutlet UILabel *deliveryMessage;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *trackingNumber;
@property (strong, nonatomic) NSMutableDictionary *arrayOfPackages;


@end

NS_ASSUME_NONNULL_END
