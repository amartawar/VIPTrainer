//
//  KBNutritionList.m
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBNutritionList.h"
#import "Nutrition.h"
#import "KBNutritionCell.h"

@interface KBNutritionList ()

@end

@implementation KBNutritionList{
    BOOL firstDisplay;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.nutritionArray = [[NSMutableArray alloc] init];
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
    //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            self.nutritionArray = objects;
            
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
    
    Nutrition *nutrition = self.nutritionArray[indexPath.row];
    
    
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
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nutritionArray.count;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformTranslate(cell.transform, -50, 0);
    cell.alpha = 0;
    
    if(firstDisplay){
        
        int cellsAbove = 0;
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

- (IBAction)submit:(id)sender {
    
    if(!DATA.partnership.recommendedProducts)
        DATA.partnership.recommendedProducts = [[NSMutableArray alloc] init];
    
    [DATA.partnership.recommendedProducts removeAllObjects];
    for(int i = 0; i < [[self.table indexPathsForSelectedRows] count]; i++){
        NSIndexPath *ip = [[self.table indexPathsForSelectedRows] objectAtIndex:i];
        [DATA.partnership.recommendedProducts addObject:[self.nutritionArray objectAtIndex:ip.row]];
    }
    [self showProgress:@"Saving"];
    [DATA.partnership saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            [self showMessage:@"Recommendations Saved"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showMessage:@"Unable to save recommendations"];
        }
    }];
}
@end
