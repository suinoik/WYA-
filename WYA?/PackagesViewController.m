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
@property (strong, nonatomic) NSMutableDictionary *arrayOfPackages;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation PackagesViewController
NSString const *kEasyPostTestTrackingCode = @"EZ1000000001";
NSString const *kEasyPostAPIKey = @"RVpUSzQ1ZjM5ZjY3NDA1YjRmNzg4ZmVmZDVjY2I5NjEyNDdlY0lGeTZrNENONU9qcWxrM2dBaXFuQQ==";
NSString const *kEasyPostTestCarrier = @"USPS";



- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
            mySceneDelegate.window.rootViewController = loginViewController;
        
        
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
     [self.tableView reloadData];

    [refreshControl endRefreshing];
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
               self.arrayOfPackages = (NSMutableDictionary *) dataDictionary;
               NSLog(@"test2 %@", dataDictionary);
               NSLog(@"actually returned something %@", self.arrayOfPackages);
           }
        [self.tableView reloadData];

       }];
    
    [task resume];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTracker];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(createTracker) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
    self.tableView.dataSource = self;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"packageCell" forIndexPath:indexPath];
    cell.carrier.text = self.arrayOfPackages[@"carrier"];
    cell.deliveryDate.text = self.arrayOfPackages[@"est_delivery_date"];
    cell.deliveryMessage.text = self.arrayOfPackages[@"message"];
    cell.status.text = self.arrayOfPackages[@"status"];
    cell.trackingNumber.text = self.arrayOfPackages[@"tracking_code"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _arrayOfPackages.count;
    return 1;
  
}



    
    

@end
