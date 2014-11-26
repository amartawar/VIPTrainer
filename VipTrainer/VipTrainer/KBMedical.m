//
//  KBMedical.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBMedical.h"
#import "Condition.h"
#import "NSArray+JSON.h"
#import "NSDictionary+JSON.h"
#import "KBMedicalCell.h"

@interface KBMedical ()

@end

@implementation KBMedical{
    int *selectedRow;
    NSMutableArray *conditionsArray;
    NSMutableArray *cells;
    
    NSString *namePlaceholder;
    NSString *affectedPlaceholder;
    NSString *commentsPlaceholder;
    
    BOOL shouldSave;
    
    UITapGestureRecognizer *gestureRecognizer;
}

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
        selectedRow = -1;
        conditionsArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!DATA.user.conditions){
        DATA.user.conditions = [[NSMutableArray alloc] init];
        DebugLog(@"initializig data.user.conditions");
    }
    
    
    for(NSString *json in DATA.user.conditions){
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error;
        Condition *condition = [[Condition alloc] init];
        NSDictionary *conditionDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&error];
        
        
        if(error){
            DebugLog(@"error parsing json:%@", error.description);
        }
        
        
        condition.name = [conditionDictionary objectForKey:@"name"];
        condition.affected = [conditionDictionary objectForKey:@"affected"];
        condition.comment = [conditionDictionary objectForKey:@"comment"];
        [conditionsArray addObject:condition];
    }


    
    
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deselectAll)];
    [gestureRecognizer setCancelsTouchesInView:NO];
    [self.table addGestureRecognizer:gestureRecognizer];
    
	// Do any additional setup after loading the view.
}

- (void) deselectAll {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
        shouldSave = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag < conditionsArray.count){
        Condition *condition = conditionsArray[textField.tag];
        
        if([textField.placeholder isEqualToString:namePlaceholder]){
            condition.name = textField.text;
        }
        else if([textField.placeholder isEqualToString:affectedPlaceholder]){
            condition.affected = textField.text;
        }
        else if([textField.placeholder isEqualToString:commentsPlaceholder]){
            condition.comment = textField.text;
        }
    }

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(conditionsArray.count == 0 && self.noConditionsButton.hidden)
        self.noConditionsButton.hidden = NO;
    else if(conditionsArray.count > 0 && !self.noConditionsButton.hidden)
        self.noConditionsButton.hidden = YES;
    
    return conditionsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self expandAtIndex:indexPath];


}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)expandAtIndex:(NSIndexPath *)indexPath{
    
    if(!indexPath)
        return;
    
    int prevSelectedRow = selectedRow;
    selectedRow = indexPath.row;
    
    if(prevSelectedRow < conditionsArray.count){
        
        if(prevSelectedRow != selectedRow)
            [self.table reloadRowsAtIndexPaths:@[indexPath, [NSIndexPath indexPathForRow:prevSelectedRow inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        else
            [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
}

-(void)collapseAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!indexPath)
        return;
    
    selectedRow = -1;
    [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // To "clear" the footer view
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *medicalCellIdentifier = @"medicalCell";
    Condition *condition = conditionsArray[indexPath.row];
    
    KBMedicalCell *cell;

    cell = [self.table dequeueReusableCellWithIdentifier:medicalCellIdentifier];
        
    cell.affectedField.tag = indexPath.row;
    cell.commentsField.tag = indexPath.row;
    cell.nameField.tag = indexPath.row;
        
    cell.affectedField.delegate = self;
    cell.commentsField.delegate = self;
    cell.nameField.delegate = self;
    
    cell.nameLabel.text = condition.name;
    cell.nameField.text = condition.name;
    cell.affectedField.text = condition.affected;
    cell.commentsField.text = condition.comment;
    
    cell.nameField.delegate = self;
    cell.affectedField.delegate = self;
    cell.commentsField.delegate = self;

    
    if(selectedRow == indexPath.row){
        [cell setExpanded:YES];
    }
    else{
        [cell setExpanded:NO];
    }
    
    if(!namePlaceholder){
        namePlaceholder = cell.nameField.placeholder;
        affectedPlaceholder = cell.affectedField.placeholder;
        commentsPlaceholder = cell.commentsField.placeholder;
    }
    
    if(!cell){
        
    }
    
    return cell;
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [conditionsArray removeObjectAtIndex:indexPath.row];
    if(indexPath.row == selectedRow){
        selectedRow = -1;
    }
    [self.table reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selectedRow == indexPath.row)
        return 140;
    else
        return 44;
}

- (IBAction)save:(id)sender {
    
    if(!shouldSave){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSMutableArray *conditionsJsonArray = [[NSMutableArray alloc] init];
    
    for(Condition *condition in conditionsArray){
        
        if(condition.name.length != 0){
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setObject:condition.name forKey:@"name"];
            [dictionary setObject:condition.affected forKey:@"affected"];
            [dictionary setObject:condition.comment forKey:@"comment"];
            
            [conditionsJsonArray addObject:[dictionary jsonStringWithPrettyPrint:YES]];
            
            
        }

    }
    
    DATA.user.conditions = conditionsJsonArray;
    
    [self showProgress:@"Saving"];
    [DATA.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showMessage:@"Failed to save"];
        }
    }];
    
    
    
    
    
    
    
    
}

- (IBAction)add:(id)sender {
    Condition *condition = [[Condition alloc] init];
    [conditionsArray addObject:condition];
    [self.table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:conditionsArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self expandAtIndex:[NSIndexPath indexPathForRow:conditionsArray.count - 1 inSection:0]];
    
}
@end
