//
//  DetailViewController.h
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) NSDictionary *verbList;
@property (strong, nonatomic) NSArray *verbListKeys;

@end
