//
//  DetailViewController.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import "DetailViewController.h"
#import "WordCell.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

@synthesize verbList;
@synthesize verbListKeys;


#pragma mark - Managing the detail item

- (void)setVerbList:(NSDictionary*)newVerbList {
    if (verbList != newVerbList) {
        verbList = newVerbList;
        verbListKeys = [self shuffle:[newVerbList allKeys]];
    
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[WordCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void) loadView
{
    self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create a flow layout for the collection view that scrolls
    // horizontally and has no space between items
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fr_bg.png"]];
    self.imageView.frame = self.view.frame;
    self.imageView.alpha = 0.2;
    [self.view addSubview:self.imageView];
    
    // Set up the collection view with no scrollbars, paging enabled
    // and the delegate and data source set to this view controller
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)shuffle:(NSArray *)input
{
    NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:input];
    
    for (int i=0; i<keys.count; i++) {
        int e = keys.count - i;
        int n = (random() % e) + i;
        
        [keys exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return keys;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return verbListKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue a prototype cell and set the label to indicate the page
    NSString *key = [verbListKeys objectAtIndex:indexPath.row];
    WordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *p = [[verbList objectForKey:key] componentsSeparatedByString:@"|"];
    
    cell.labelWord.text = key;
    cell.labelTranslation.text = [[p objectAtIndex:0] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
    cell.labelDetails.text = [[p objectAtIndex:1] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
        
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

@end
