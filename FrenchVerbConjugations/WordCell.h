//
//  WordCell.h
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/04/09.
//  Copyright (c) 2013 Blacklemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelWord;
@property (strong, nonatomic) IBOutlet UILabel *labelTranslation;
@property (strong, nonatomic) IBOutlet UILabel *labelDetails;
@property (strong, nonatomic) IBOutlet UILabel *labelDetailTranslation;

@end
