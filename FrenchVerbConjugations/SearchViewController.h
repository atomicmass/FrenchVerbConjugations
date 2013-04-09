//
//  SearchViewController.h
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/04/02.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSDictionary *resultsDic;
@property (strong, nonatomic) NSArray *results;
@property (weak, nonatomic) IBOutlet UISearchBar *searchControl;
@property (strong, nonatomic) MasterViewController *masterController;
@property (strong, nonatomic) NSString *selectedKey;

@end
