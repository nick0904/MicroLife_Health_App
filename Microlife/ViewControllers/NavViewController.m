//
//  NavViewController.m
//  Microlife
//
//  Created by 點睛 on 2016/9/21.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "NavViewController.h"

@implementation NavViewController
{
    UIPageControl *pageControl;
    UIScrollView *navScrollView;
}
@synthesize navImageArray,navTextArray;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initParameter];
    [self initInterface];
}

-(void)initParameter
{
    navImageArray=[[NSMutableArray alloc]init];
    navTextArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++)
    {
        [navImageArray addObject:[NSString stringWithFormat:@"walkthrough_%d",i+1]];
    }
    [navTextArray addObject:@"At microlife, we are deeply committed to empower you and your loved ones to live healthier lives."];
     [navTextArray addObject:@"Our mission is to bring innovative medical technologies to your home to make health management easier, smarter, and more accurate."];
     [navTextArray addObject:@"Use Microlife Connect Health + for simple overview and safekeeping of your readings. Stay on top of your health with ease, anytime, anywhere."];
     [navTextArray addObject:@"Set goals and reminders to establish healthy routines and monitor progresses for you and your loved ones."];
     [navTextArray addObject:@"Your partner for better health management."];
}

-(void)initInterface
{
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-self.view.bounds.size.height*0.05-50, self.view.bounds.size.width, self.view.bounds.size.height*0.02)];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"walkthrough_page_1"]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"walkthrough_page_0"]];
    
    navScrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    navScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*navImageArray.count, SCREEN_HEIGHT);
    navScrollView.pagingEnabled=YES;
    navScrollView.bounces=NO;
    navScrollView.delegate=self;
    
    for (int i=0; i<navImageArray.count; i++)
    {
        
        UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        UILabel *navTextlabel=[[UILabel alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT*920/1334, SCREEN_WIDTH-80,100)];
        [navTextlabel setNumberOfLines:0];
        [navTextlabel setLineBreakMode:NSLineBreakByWordWrapping];
        [navTextlabel setText:[navTextArray objectAtIndex:i]];
        
        CGSize size = [navTextlabel sizeThatFits:CGSizeMake(navTextlabel.frame.size.width, MAXFLOAT)];
        [navTextlabel setFrame:CGRectMake(40, SCREEN_HEIGHT*920/1334, SCREEN_WIDTH-80,size.height)];
        [navTextlabel setTextColor:[UIColor whiteColor]];
        [navTextlabel setTextAlignment:NSTextAlignmentCenter];
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backImageView.image=[self resizeImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[navImageArray objectAtIndex:i]]]];
        [navView addSubview:backImageView];
        [navView addSubview:navTextlabel];
        
        //最後一頁
        if (i==navTextArray.count-1)
        {
            UIButton *privacyBtn=[[UIButton alloc]init];
            [privacyBtn setBackgroundImage:[UIImage imageNamed:@"walkthrough_btn_privacy"] forState:UIControlStateNormal];
            [privacyBtn setTitle:@"Privacy Mode" forState:UIControlStateNormal];
            [privacyBtn setTintColor:[UIColor whiteColor]];
            [privacyBtn setFrame:CGRectMake(SCREEN_WIDTH*220/750, SCREEN_HEIGHT*1050/1334, 300*SCREEN_WIDTH/750, 100*SCREEN_HEIGHT/1334)];
            [privacyBtn addTarget:self action:@selector(clickPrivacyBtn) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*165/750, SCREEN_HEIGHT*830/1334, 400*SCREEN_WIDTH/750, 100*SCREEN_HEIGHT/1334)];
            
            [logoImage setImage:[UIImage imageNamed:@"walkthrough_logo"]];
            
            UIButton *nextPageBtn=[[UIButton alloc]init];
            [nextPageBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-100*SCREEN_HEIGHT/1334, SCREEN_WIDTH, 100*SCREEN_HEIGHT/1334)];
            [nextPageBtn setBackgroundColor:STANDER_COLOR];
            [nextPageBtn setTitle:@"NextPage" forState:UIControlStateNormal];
            [nextPageBtn setTintColor:[UIColor whiteColor]];
            [nextPageBtn addTarget:self action:@selector(clickNextPageBtn) forControlEvents:UIControlEventTouchUpInside];
            [navView addSubview:privacyBtn];
            [navView addSubview:logoImage];
            [navView addSubview:nextPageBtn];
        }
        
        [navScrollView addSubview:navView];
    }

    [self.view addSubview:navScrollView];
    [self.view addSubview:pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == navScrollView)
    {
        CGFloat width = scrollView.frame.size.width;
        NSInteger currentPage = ((scrollView.contentOffset.x - width / 2) / width) + 1;
        [pageControl setCurrentPage:currentPage];
    }
}

-(void)clickPrivacyBtn
{
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)clickNextPageBtn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"UserLoginViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end