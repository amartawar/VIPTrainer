//
//  KBSplitViewController.m
//  VendevorIpad
//
//  Created by kyle barnes on 5/26/13.
//  Copyright (c) 2013 Kyle Barnes. All rights reserved.
//

#import "KBSplitViewController.h"
#import "FXBlurView.h"
#import "KBClientList2.h"
#import "KBTrainerSummary.h"
#import <QuartzCore/QuartzCore.h>

@interface KBSplitViewController ()

@end

@implementation KBSplitViewController
{
    UISwipeGestureRecognizer *leftRecognizer;
    UISwipeGestureRecognizer *rightRecognizer;
    UITapGestureRecognizer *tapRecognizer ;
    
    UIToolbar *tintView;
    Boolean master_is_open;
    Boolean master_is_fullscreen;
    
    CGRect masterView_closed;
    CGRect masterView_open;
    CGRect masterView_fullscreen;
    
    CGRect detailView_closed;
    CGRect detailView_open;
    CGRect detailView_fullscreen;
    
    NSArray *materVerticalConstraints;
    NSArray *materHorizontalConstraints;
    
    NSArray *detailVerticalConstraints;
    NSArray *detailHorizontalConstraints;
    int lastControllerIndex;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
     [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showChatThread)
                                                 name:@"showChat"
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showOrderDetails)
                                                 name:@"showOrder"
                                               object:self.view.window];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    self.masterView.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableDrawer)
                                                 name:@"enableMenu"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disableDrawer)
                                                 name:@"disableMenu"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ShowMaster:)
                                                 name:@"openMenu"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(HideMaster)
                                                 name:@"closeMenu"
                                               object:nil];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    

    
    
    leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(HideMaster)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ShowMaster:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMaster)];
    [tapRecognizer setCancelsTouchesInView:YES];
    
    
    tintView = [[UIToolbar alloc] init];
    [tintView setBarStyle:UIBarStyleBlack];
    [tintView setBarTintColor:vipLightGray];
    
    
    //tapOffView = [[FXBlurView alloc] init];
    //[tapOffView setTintColor:[UIColor redColor]];
    // tapOffView.dynamic = NO;
    
    //tintView = [[UIView alloc] init];
    //[tintView setBackgroundColor:[UIColor colorWithRed:3/255.0 green:200.0/255.0 blue:49.0/255.0	 alpha:1]];
    //[tintView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0.0/255.0 blue:0.0/255.0	 alpha:1]];
    [tintView setHidden:YES];
    //[tapOffView setHidden:YES];
    
    //[self.view insertSubview:tintView aboveSubview:self.detailView];
    //[self.view insertSubview:tapOffView aboveSubview:tintView];
    //[self.view insertSubview:tapOffView aboveSubview:self.detailView];
    
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self addDetailController:controller animated:YES];

    
    float screenWidth = self.view.frame.size.width;
    float screenHeight = self.view.frame.size.height;
    
    //(screenWidth*2/3)
    float masterWidth = 165;
    
    masterView_closed = CGRectMake(-masterWidth, 0, masterWidth, screenHeight);
    masterView_open = CGRectMake(0, 0, masterWidth, screenHeight);
    
    detailView_closed = CGRectMake(0, 0, screenWidth, screenHeight);
    detailView_open = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
    
    
    [tintView setFrame:masterView_closed];
    [self.view insertSubview:tintView aboveSubview:self.detailView];
    
    //KBSideMenu_Trainer *sideMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"sideMenuTrainer"];
    //[self addMasterController:sideMenu animated:YES];
    
    //KBNotificationWindow *notification = [self.storyboard instantiateViewControllerWithIdentifier:@"notificationWindow"];
    //[self addMasterController:notification animated:YES];
    
    [self enableDrawer];
    
   
    
    // Do any additional setup after loading the view from its nib.
}

-(void)logoff{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logged_off)
                                                 name:@"logout"
                                               object:nil];
}

-(void)disableDrawer{
    [self.view removeGestureRecognizer:leftRecognizer];
    [self.view removeGestureRecognizer:rightRecognizer];
    [self.detailView removeGestureRecognizer:tapRecognizer];
}
-(void)enableDrawer{
    [self.view addGestureRecognizer:leftRecognizer];
    [self.view addGestureRecognizer:rightRecognizer];
    [self.detailView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMasterController:(UIViewController*)controller animated:(BOOL)anim
{
    
    if(self.masterViewController)
       [self.masterViewController.view removeFromSuperview];
    
    self.masterViewController = controller;
    [self addChildViewController:self.masterViewController];
    [self.masterViewController didMoveToParentViewController:self];
    
    UIView *view = self.masterViewController.view;
    [self.masterView addSubview:self.masterViewController.view];
    materVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    materHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    [self.masterView addConstraints:materVerticalConstraints];
    [self.masterView addConstraints:materHorizontalConstraints];
}

-(void)loadTrainerSideMenu{
    KBSideMenu_Trainer *sideMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"sideMenuTrainer"];
    [self addMasterController:sideMenu animated:YES];
    [self loadLandingTrainer];
}
-(void)loadClientSideMenu{
    KBSideMenu_Client *sideMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"sideMenuClient"];
    [self addMasterController:sideMenu animated:YES];
    [self loadLandingClient];
}


-(void)transitionUpToController:(UIViewController*)controller animated:(BOOL)animated up:(BOOL)up{
    
    [self HideMaster];
    
    DebugLog(@"transitioning");
    UIViewController *src = (UIViewController *) self.detailViewController;
    
    
    if(!controller.navigationController)
        self.detailViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    else
        self.detailViewController = controller;
    
    [self addChildViewController:self.detailViewController];
    [self.detailViewController didMoveToParentViewController:self];
    [self.detailViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *view = self.detailViewController.view;
    [self.detailView addSubview:self.detailViewController.view];
    
    detailVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    detailHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    
    UIView *detailview = self.detailView;
    
    //NSArray *detailContainerHoriztonalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[detailview(==320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailview)];
    //NSArray *detailContainerVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[detailview]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailview)];
    [self.detailView addConstraints:detailVerticalConstraints];
    [self.detailView addConstraints:detailHorizontalConstraints];
    //[self.view addConstraints:detailContainerHoriztonalConstraints];
    //[self.view addConstraints:detailContainerVerticalConstraints];
    [self.view layoutIfNeeded];
    
    
    if(animated){
    
        float directionMultiplier = up? -1 : 1;
        
        
        view.transform = CGAffineTransformMakeTranslation(0, src.view.frame.size.height * directionMultiplier);
        src.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
        
        
        [UIView transitionWithView:src.navigationController.view duration:.4
                           options:UIViewAnimationOptionCurveEaseInOut
                        animations:^{
                            view.transform = CGAffineTransformMakeTranslation(0, 0);
                            src.view.transform = CGAffineTransformMakeTranslation(0, -src.view.frame.size.height * directionMultiplier);
                        }
                        completion:^(BOOL finished) {
                            [src removeFromParentViewController];
                            [src.view removeFromSuperview];
                        }];
        
    }
    else{
        [src removeFromParentViewController];
        [src.view removeFromSuperview];
    }
}

- (void)addDetailController:(UIViewController *)controller animated:(BOOL)anim
{
    
    if(!controller.navigationController)
        self.detailViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    else
        self.detailViewController = controller;
    
    [self addChildViewController:self.detailViewController];
    [self.detailViewController didMoveToParentViewController:self];
    [self.detailViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    UIView *view = self.detailViewController.view;
    [self.detailView addSubview:self.detailViewController.view];
    
    detailVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    detailHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    
    UIView *detailview = self.detailView;
    
    //NSArray *detailContainerHoriztonalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[detailview(==320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailview)];
    //NSArray *detailContainerVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[detailview]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailview)];
    [self.detailView addConstraints:detailVerticalConstraints];
    [self.detailView addConstraints:detailHorizontalConstraints];
    //[self.view addConstraints:detailContainerHoriztonalConstraints];
    //[self.view addConstraints:detailContainerVerticalConstraints];
    
    [self.view layoutIfNeeded];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)ShowMaster:(UISwipeGestureRecognizer *)recognizer{
    
    DebugLog(@"showing master");
    self.masterWidthConstraint.constant = masterView_open.size.width;
    self.masterPositionConstraint.constant = masterView_open.origin.x;
    //self.detailPositionConstraint.constant = detailView_open.origin.x;
    
    [self.masterViewController performSelector:@selector(refreshCounters)];
    
    if(!master_is_open){

       // tapOffView.frame = self.view.frame;

        //[tapOffView setAlpha:0];
        //[tapOffView setHidden:NO];
        [tintView setHidden:NO];
        //tapOffView.dynamic = YES;
        //[tapOffView setNeedsDisplay];
        
        [UIView animateWithDuration:.2
                              delay:0
                            options: nil
                         animations:^{
                             [self.view layoutIfNeeded];
                             [tintView setFrame:masterView_open];
                         }
                         completion:^(BOOL finished){
                             //tapOffView.dynamic = NO;
                             [self.detailView addGestureRecognizer:tapRecognizer];
                            
                         }];
        master_is_open = true;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view layoutSubviews];
}

- (IBAction)HideMaster{
    [self.masterView endEditing:YES];
    [self.detailView removeGestureRecognizer:tapRecognizer];
    self.masterWidthConstraint.constant = masterView_closed.size.width;
    self.masterPositionConstraint.constant = masterView_closed.origin.x;
    //self.detailPositionConstraint.constant = detailView_closed.origin.x;
    if(master_is_open){
        [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded];
                         [tintView setFrame:masterView_closed];
                         
                     }
                     completion:^(BOOL finished){
                         tintView.hidden = YES;

                     }];
        master_is_open = false;
    }
}

- (IBAction)fullscreen:(id)sender {
    self.masterWidthConstraint.constant = masterView_fullscreen.size.width;
    self.masterPositionConstraint.constant = masterView_fullscreen.origin.x;
    //tapOffView.dynamic = YES;
    [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded];
                         
                     }
                     completion:^(BOOL finished){
                         //tapOffView.dynamic = NO;
                     }];
    master_is_fullscreen = true;
    
}

- (IBAction)close:(id)sender {
    self.masterWidthConstraint.constant = masterView_closed.size.width;
    self.masterPositionConstraint.constant = masterView_closed.origin.x;
    //tapOffView.dynamic = YES;
    [self.detailView removeGestureRecognizer:tapRecognizer];
    [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                        [self.view layoutIfNeeded];
                         //tapOffView.alpha = 0;
                        
                         
                     }
                     completion:^(BOOL finished){
                         //tapOffView.hidden = YES;
                         tintView.hidden = YES;
                          //tapOffView.dynamic = NO;
                     }];
    master_is_fullscreen = false;
    master_is_open = false;
}

-(void)loadNotifications{
    
}

-(void)loadToday{

    
    [self HideMaster];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"todayWorkout"];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)loadWeek{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    if(1 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(1 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 1;
}

-(void)loadClients{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"clientList2"];
    
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 0;
}

-(void)loadNutrition{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBClientList2 *controller = [storyboard instantiateViewControllerWithIdentifier:@"clientList2"];
    controller.filterByType = [NSNumber numberWithInt:CLIENT_NEEDS_PRODUCTS];
    
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 0;
}

-(void)loadClientNutrition{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"clientNutrition"];
    
    if(3 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(3 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 3;
}



-(void)loadProgress
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Progress" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    if(3 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(3 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    
    lastControllerIndex = 3;
    
}




-(void)loadChats{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    if(1 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(1 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    
    lastControllerIndex = 1;
    
}

-(void)loadProfile{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    if(4 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(4 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 4;
    
}

-(void)loadTrainerProfile{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Profile_Trainer"];
    
    if(4 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(4 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 4;
    
}





-(void)loadSettings{
    return;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"settings"];
    
    if(5 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(5 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 5;
    
}

-(void)loadLandingTrainer{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"landingTrainer"];
    
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 0;
    
}

-(void)loadLandingClient{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"landingClient"];
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 0;
    
}

-(void)loadTrainer{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBTrainerSummary *controller = [storyboard instantiateViewControllerWithIdentifier:@"viewTrainer"];
    controller.user = DATA.partnership.trainer;
    DebugLog(@"Trainer Controller set");
    
    if(4 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(4 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 4;
    
}

-(void)loadNewClients{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBClientList2 *controller = [storyboard instantiateViewControllerWithIdentifier:@"clientList2"];
    controller.filterByType = [NSNumber numberWithInt:CLIENT_COMPLETED_INTERVIEW];
    
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 0;
    
}

-(void)loadFeedback{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBClientList2 *controller = [storyboard instantiateViewControllerWithIdentifier:@"clientList2"];
    controller.filterByType = [NSNumber numberWithInt:CLIENT_FINISHED_WORKOUT];
    
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 0;
    
}

-(void)loadNeedsWorkout{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBClientList2 *controller = [storyboard instantiateViewControllerWithIdentifier:@"clientList2"];
    controller.filterByType = [NSNumber numberWithInt:CLIENT_COMPLETED_FITNESS_ASSESSMENT];
    
    if(0 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(0 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    lastControllerIndex = 0;
    
}



-(void)loadProducts{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    if(4 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(4 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 4;
    
}

-(void)loadMeals{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Meals" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    if(4 < lastControllerIndex)
        [self transitionUpToController:controller animated:YES up:YES];
    else if(4 == lastControllerIndex)
        [self transitionUpToController:controller animated:NO up:NO];
    else{
        [self transitionUpToController:controller animated:YES up:NO];
    }
    
    lastControllerIndex = 4;
    
}

-(void)logout{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Open" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [self transitionUpToController:controller animated:NO up:NO];
    
}

- (IBAction)Toggle_Menu:(id)sender {
    if(master_is_open)
       [self HideMaster];
    else
        [self ShowMaster:nil];
}

-(void)setLastControllerIndex:(int) index{
    lastControllerIndex = index;
}



@end
