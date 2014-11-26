//
//  KBNutritionList.m
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBClientNutrition.h"
#import "Nutrition.h"
#import "KBNutritionCell.h"

@interface KBClientNutrition ()

@end

@implementation KBClientNutrition{
    BOOL firstDisplay;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.nutritionArray = [[NSMutableArray alloc] init];
        self.recommendNutritionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    firstDisplay = TRUE;
}

-(void)viewDidLoad{
    [self loadNutrition];
}

-(void)loadNutrition{
    
    [self showProgress:@"Fetching Products"];
    
    
    PFQuery *query = [Nutrition query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            self.nutritionArray = objects;
            
           self.recommendNutritionArray = [[NSMutableArray alloc] init];
            
            for(Nutrition *n in objects){
                
                for(Nutrition *rn in DATA.partnership.recommendedProducts){
                    if([rn.objectId isEqualToString:n.objectId]){
                        [self.recommendNutritionArray addObject:n];
                    }
                }
            }
            
            [self.table reloadData];
        }
        else{
            
        }
    }];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *productCollectionCellIdentifier = @"nutritionCell";
    
    KBNutritionCell *cell = [self.table dequeueReusableCellWithIdentifier:productCollectionCellIdentifier];
    
    if(!cell){
        
    }
    
    
    Nutrition *nutrition;
    
    if(indexPath.section == 0 && self.recommendNutritionArray.count > 0)
        nutrition = self.recommendNutritionArray[indexPath.row];
    else
        nutrition = self.nutritionArray[indexPath.row];
    
    
    cell.picture.file = nutrition.picture;
    [cell.picture loadInBackground];
    
    cell.nameLabel.text = nutrition.name;
    cell.sizeLabel.text = nutrition.size;
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:nutrition.price];
    cell.priceLabel.text = numberAsString;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Nutrition *nutrition = self.nutritionArray[indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nutrition.url]];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0 && self.recommendNutritionArray.count > 0)
        return self.recommendNutritionArray .count;
    else
        return self.nutritionArray.count;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section==0 && self.recommendNutritionArray.count > 0)
        return @"Recommended by your trainer";
    else
        return @"Other Products";
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(self.recommendNutritionArray.count > 0)
        return 2;
    else
        return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformTranslate(cell.transform, -50, 0);
    cell.alpha = 0;
    
    if(firstDisplay){
        
        int cellsAbove = 0;
        for(int i = 0; i < indexPath.section; i++){
            
            int numberInSection = [self tableView:tableView numberOfRowsInSection:i];
            
            cellsAbove += numberInSection;
        }
        
        cellsAbove += indexPath.row;
        
        [UIView animateWithDuration:.2 delay:cellsAbove*.08 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {
            firstDisplay = false;
        }];
    }
    else{
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {}];
        
    }
}

@end
