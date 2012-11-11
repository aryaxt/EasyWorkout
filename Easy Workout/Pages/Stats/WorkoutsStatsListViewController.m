//
//  WorkoutsStatsListViewController.m
//  Easy Workout
//
//  Created by Aryan Gh on 11/4/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutsStatsListViewController.h"

@implementation WorkoutsStatsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:hostingView];
	
	CPTGraph *graph = [[CPTGraph alloc] initWithFrame:hostingView.bounds];
	hostingView.hostedGraph = graph;
	
	CPTBarPlot *barPlot = [[CPTBarPlot alloc] init];
	[graph addPlot:barPlot];
	barPlot.dataSource = self;
	
	WorkoutStatsGraphView *g = [[WorkoutStatsGraphView alloc] init];
	[self.view addSubview:g];*/
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

#pragma mark - CPTBarPlot Datasource & Delegate 

/*-(NSUInteger)numberOfRecordsForPlot:(CPTBarPlot *)plot
{
	return 5;
}

-(NSNumber *)numberForPlot:(CPTBarPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	return [NSNumber numberWithInteger:index];
}*/

@end
