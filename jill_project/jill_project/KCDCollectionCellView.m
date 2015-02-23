//
//  UICollectionViewCell+KCDCollectionCellView.m
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDCollectionCellView.h"

@interface KCDCollectionCellView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *labelOutlet;

@end

@implementation KCDCollectionCellView

-(void) setCell:(NSMutableDictionary *)typeClothes{
    
    UIImage * imageI = [UIImage imageNamed:[typeClothes objectForKey:@"image"]];
    
    self.imageOutlet.image = imageI;
    [self.labelOutlet setText:[typeClothes objectForKey:@"name"]];
}

@end
