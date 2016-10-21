//
//  ViewController.h
//  Weather
//
//  Created by Oguz Birinci on 21/10/2016.
//  Copyright © 2016 Oguz Birinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

