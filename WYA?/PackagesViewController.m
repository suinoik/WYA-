//
//  PackagesViewController.m
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/7/22.
//

#import "PackagesViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "PackageCell.h"
#import "PackageDetailViewController.h"


@interface PackagesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPackages;


@end

@implementation PackagesViewController
- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
            mySceneDelegate.window.rootViewController = loginViewController;
        
        
    }];
}

- (void) createTracker {
    NSURL *url = [NSURL URLWithString:@"https://api.easypost.com/v2/trackers"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"Basic RVpUSzQ1ZjM5ZjY3NDA1YjRmNzg4ZmVmZDVjY2I5NjEyNDdlY0lGeTZrNENONU9qcWxrM2dBaXFuQQ==" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *trackerBody = [NSDictionary dictionaryWithObjectsAndKeys:@"EZ1000000001", @"tracking_code", @"USPS", @"carrier", nil];
    NSDictionary *requestBodyDict = [NSDictionary dictionaryWithObjectsAndKeys:trackerBody, @"tracker", nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"test1 %@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//               NSLog(dataDictionary);
               self.arrayOfPackages = dataDictionary[@"id"];
               NSLog(@"test2 %@", dataDictionary);
               NSLog(@"actually returned something %@", self.arrayOfPackages);
//               NSLog(@"test2 %@", self.arrayOfPackages);
           }
        [self.tableView reloadData];
        [task resume];

       }];
    
    [task resume];
}

//- (void) createPackage {
//    NSURL *url = [NSURL URLWithString:@"https://api.easypost.com/v2/parcels"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request addValue:@"Basic RVpUSzQ1ZjM5ZjY3NDA1YjRmNzg4ZmVmZDVjY2I5NjEyNDdlUVFLNGY4ckNBb1AxSHBLOVVEUGpsQQ==" forHTTPHeaderField:@"Authorization"];
//    [request setHTTPMethod:@"POST"];
//    NSDictionary *parcelBody = [NSDictionary dictionaryWithObjectsAndKeys:@"20", @"length", @"10", @"width", @"5", @"height", @"65", @"weight", nil];
//        NSDictionary *requestBodyDict = [NSDictionary dictionaryWithObjectsAndKeys:parcelBody, @"parcel", nil];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestBodyDict options:kNilOptions error:nil];
//    [request setHTTPBody:postData];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//           if (error != nil) {
//               NSLog(@"test3 %@", [error localizedDescription]);
//           }
//           else {
//               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//               self.arrayOfPackages = dataDictionary[@"id"];
//               NSLog(@"test4 %@", self.arrayOfPackages);
//           }
//        [self.tableView reloadData];
//
//       }];
//
//    [task resume];
//
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if([[segue identifier] isEqualToString:@"composeSegue"]){
//        UINavigationController *navigationController = [segue destinationViewController];
//        PackageDetailViewController *composeController = (PackageDetailViewController*)navigationController.topViewController;
//        composeController.delegate = self;
//        
//    }
//}
    
//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PackageCell"];
//    cell.packagePicture;
//    cell.packageTitle;
//    return cell;
    
NSArray *data;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTracker];
    
    // Do any additional setup after loading the view.
    data = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
                 @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
                 @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
                 @"Jacksonville, FL", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
                 @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Fort Worth, TX"];
        self.tableView.dataSource = self;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PackageCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = data[indexPath.row];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}



    
    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
