//
//  RepoModel.m
//  GithubRepos
//
//  Created by Kevin Cleathero on 2017-06-19.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "RepoModel.h"

@implementation RepoModel

- (instancetype)initWithName:(NSString *)reponame
{
    self = [super init];
    if (self) {
        _repoName = reponame;
    }
    return self;
}

@end
