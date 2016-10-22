//
//  ViewController.m
//  Weather
//
//  Created by Oguz Birinci on 21/10/2016.
//  Copyright © 2016 Oguz Birinci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)NSArray *detailArray;
@property (nonatomic, strong)NSArray *weatherArray;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:
                                            [NSURL URLWithString:@"http://api.openweathermap.org/"]];
    [sessionManager GET:@"data/2.5/group?"
             parameters:@{@"id" : @"751817, 5162774, 5128581, 745042, 738648, 740430, 315368, 2618425, 2988507, 2509954",
                          @"appid" : @"a01d93cbe2de5a697d6e93104af0672b"}
               progress:^(NSProgress * _Nonnull downloadProgress) { }
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
                    self.weatherArray = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"list"]];
                    [self.tableView reloadData];
                }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){}];
    
    if (self.detailArray)
    {
        [self.lblDetailName setText:
         [NSString stringWithFormat:@"%@ / %@",
          [[self.weatherArray objectAtIndex:self.indexPath.row] objectForKey:@"name"],
          [[[self.weatherArray objectAtIndex:self.indexPath.row] objectForKey:@"sys"] objectForKey:@"country"]]];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weatherArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
   
    [((UILabel *)[cell viewWithTag:1000]) setText:
     [NSString stringWithFormat:@"%@ / %@",
      [[self.weatherArray objectAtIndex:indexPath.row] objectForKey:@"name"],
       [[[self.weatherArray objectAtIndex:indexPath.row] objectForKey:@"sys"] objectForKey:@"country"]]];
    
    [((UILabel *)[cell viewWithTag:1001]) setText:
     [NSString stringWithFormat:@"%@ - Temp : %.2f°C",
      [[[[self.weatherArray objectAtIndex:indexPath.row] objectForKey:@"weather"] firstObject] objectForKey:@"description"],
      [[[[self.weatherArray objectAtIndex:indexPath.row] objectForKey:@"main"] objectForKey:@"temp"] doubleValue] -273.15]];
    
    [((UIImageView *)[cell viewWithTag:1002]) sd_setImageWithURL:
     [NSURL URLWithString:
      [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",
       [[[[self.weatherArray objectAtIndex:indexPath.row] objectForKey:@"weather"] firstObject] objectForKey:@"icon"]]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:
                                            [NSURL URLWithString:@"http://api.openweathermap.org/"]];
    [sessionManager GET:@"data/2.5/forecast?"
             parameters:@{@"id" : [NSString stringWithFormat:@"%@", [[self.weatherArray objectAtIndex:indexPath.row] objectForKey:@"id"]],
                          @"appid" : @"a01d93cbe2de5a697d6e93104af0672b"}
               progress:^(NSProgress * _Nonnull downloadProgress) { }
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         self.detailArray = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"list"]];
         self.indexPath = indexPath;
     }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){}];
}



@end
