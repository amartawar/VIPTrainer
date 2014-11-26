//
//  KBMealList.m
//  VipTrainer
//
//  Created by kenney on 7/28/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBMealView.h"
#import "KBMealListCell.h"

@interface KBMealView ()

@end

@implementation KBMealView{
    bool firstDisplay;
    NSMutableArray *mealsArray;
}
@synthesize mealPlan;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        mealsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.scrollUsingTable = YES;
    
    if(!self.mealPlan){
        self.mealPlan = [MealPlan object];
        
    }
    
    
    for(int i = 0; i < mealPlan.meals.count; i++){
        NSData *data = [mealPlan.meals[i] dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
        
        Meal *meal = [[Meal alloc] initWithDictionary:dictionary];
        [mealsArray addObject:meal];
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.table addGestureRecognizer:gestureRecognizer];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) hideKeyboard {
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    firstDisplay = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *progressListCellIdentifier = @"mealListCell";
    
    KBMealListCell *cell = [self.table dequeueReusableCellWithIdentifier:progressListCellIdentifier];
    
    Meal *meal = mealsArray[indexPath.row];

        cell.titleField.text = meal.name;
        cell.descriptionTextView.text = meal.description;
        cell.calorieField.text = meal.calories;
    if(!cell){
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mealsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (IBAction)add:(id)sender {
    
    Meal *meal = [[Meal alloc] init];
    [mealsArray addObject:meal];
    [self.table reloadData];
    
}
- (IBAction)save:(id)sender {
    
    [self.mealPlan.meals removeAllObjects];
    for(Meal *meal in mealsArray){
        [self.mealPlan.meals addObject:[meal getMealString]];
    }
    
    [self showProgress:@"Saving meal plan"];
    
    [self.mealPlan saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            [self showMessage:@"Meal plan saved"];
        }
        else{
            [self showMessage:@"Unable to save meal"];
        }
    }];
}


@end
