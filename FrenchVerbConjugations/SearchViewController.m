//
//  SearchViewController.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/04/02.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize resultsDic;
@synthesize results;
@synthesize searchControl;
@synthesize masterController;
@synthesize selectedKey;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    results = [[NSArray alloc] init];
    [searchControl becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *text = [results objectAtIndex:indexPath.row];
    [[cell textLabel] setText:text];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    resultsDic = [masterController searchAllValues:searchText];
    results = [resultsDic allKeys];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedKey = [results objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier: @"showDetalFromSearch" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetalFromSearch"]) {
        NSString *value = [resultsDic objectForKey:selectedKey];
        NSDictionary *v = [[NSDictionary alloc] initWithObjectsAndKeys:value, selectedKey, nil];
        [[segue destinationViewController] setVerbList:v];
    }
}

@end
