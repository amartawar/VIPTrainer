//
//  KBProgressList.m
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBProgressList.h"
#import "KBProgressListCell.h"
#import "KBProgressView.h"
#import "KBProgressSummary.h"
#import "Progress.h"

@interface KBProgressList ()

@end

@implementation KBProgressList{
    BOOL firstDisplay;
    
}

@synthesize isModal;

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
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)viewWillAppear:(BOOL)animated{
    firstDisplay = true;
    [self loadProgress];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    if(isModal){
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
        [self.navigationItem setLeftBarButtonItem:closeButton];
    }
}

-(void)loadProgress{
    [self showProgress:@"Loading Progress History"];
    
    [DATA.progresses removeAllObjects];
    [self.table reloadData];
    PFQuery *query = [Progress query];
    [query whereKey:@"user" equalTo:CURRENTUSER];
    [query  orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            DATA.progresses = objects;
            [self.table reloadData];
        }
        else{
            
        }
    }];
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *progressListCellIdentifier = @"progressListCell";
    
    KBProgressListCell *cell = [self.table dequeueReusableCellWithIdentifier:progressListCellIdentifier];
    
    Progress *p = DATA.progresses[indexPath.row];
    
    if(!cell){
        
    }
    
    
    cell.weightLabel.text = [NSString stringWithFormat:@"%@ %@", p.weight, @"lbs"];
    cell.fatLabel.text = [NSString stringWithFormat:@"%@ %@", p.bodyFat, @"%"];
    cell.dateLabel.text = [NSDateFormatter localizedStringFromDate:p.createdAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KBProgressSummary *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"progressSummary"];
    DATA.selectedProgress = [DATA.progresses objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DATA.progresses.count;
}

- (IBAction)add:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"progressView"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)close{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
}
@end
