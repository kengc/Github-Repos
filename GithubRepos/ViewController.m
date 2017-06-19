//
//  ViewController.m
//  GithubRepos
//
//  Created by Kevin Cleathero on 2017-06-19.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "RepoModel.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *repos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.repos = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/kengc/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError){
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        for(NSDictionary *repo in repos){
            NSDictionary *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            
            RepoModel *repoObject = [[RepoModel alloc] init];
            repoObject.repoName = [NSString stringWithFormat: @"%@", repoName];
            [self.repos addObject:repoObject];
            //self.tableView = repoName;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
        });
                    
    }];
    [dataTask resume];
    
    //https://api.github.com/users/kengc/repos
}

#pragma Mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.repos.count;
}

#pragma Mark - TableView Delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    RepoModel *repoObject = self.repos[indexPath.row];
    
    cell.cellLabel.text = repoObject.repoName;
    
    return cell;

}



@end
