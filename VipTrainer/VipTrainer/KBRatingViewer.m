//
//  KBRatingViewer.m
//  VipTrainer
//
//  Created by kenney on 9/8/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBRatingViewer.h"
#import "Rating.h"

@interface KBRatingViewer ()

@end

@implementation KBRatingViewer{
    NSMutableArray *ratings;
    UIFont *labelFont;
}
@synthesize trainer_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)loadRatings{
    [self showProgress:@"Loading Ratings"];
    PFQuery *query = [Rating query];
    [query whereKey:@"trainer_id" equalTo:trainer_id];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            
            
            if(objects.count ==0 ){
                self.numberOfRatingsLabel.text = @"No ratings";
            }
            else{
                self.numberOfRatingsLabel.text = [NSString stringWithFormat:@"Number of ratings: %i", objects.count];
            }
            
            ratings = objects;
            
            [self.table reloadData];
        }
        else{
            [self showMessage:@"Failed to load ratings"];
        }
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[ratings objectAtIndex:indexPath.row] comments];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:labelFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

    return labelSize.height + 44;
}

- (void)viewDidLoad
{
    
    labelFont = [UIFont systemFontOfSize:15.0];
    [self loadRatings];
    self.starView.rating = [[[User currentUser] rating] floatValue];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ratings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ratingViewCellIdentifier = @"ratingViewCellIdentifier";
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:ratingViewCellIdentifier];
    
    if(!cell){
        
    }
    
    DebugLog(@"settings string: %@", [[ratings objectAtIndex:indexPath.row] comments]);
    cell.textLabel.text = [[ratings objectAtIndex:indexPath.row] comments];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
