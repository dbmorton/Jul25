//
//  Jul25AppDelegate.m
//  Jul25
//
//  Created by david morton on 7/25/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import "Jul25AppDelegate.h"
#include "ViewController.h"
#import "BandData.h"

@implementation Jul25AppDelegate
@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
		
	//*** START OF GETTING BAND DATA ***
	//Initialize Array for all band data sets
	_bandDataSets=[[NSMutableArray alloc] init];
	
	//Error Holder
	NSError *error = nil;
	
	//info.txt stores all the necessary information
	//<band name>,<band pic>,<Example Song Name>,<audio file>,<bio file>
	//ie. Led Zepplin,led.png,Stairway To Heaven,sth.mp3,led.txt
	NSString *path = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"txt"];
	NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	
	//how do i get something like this to work?
	//NSString *content=[getContents @"info.txt"];
	NSArray *b =[content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	
	//what should i have used for NSUInteger?
	//NSLog(@"[b count]=%u",[b count]);
	
	if(error) NSLog(@"ERROR while loading from file: %@", error);
	else{
		//NSLog(@"%@",content);
		
		for (NSUInteger j = 0; j < [b count]; ++j) {
			NSArray* foo = [b[j] componentsSeparatedByString: @","];
			//Format of File is: name of band ,name of image,Song Title,audio file,name of bio text file
			BandData *dataSet=[[BandData alloc] init];
			dataSet.bandName=foo[0];dataSet.bandImage=[UIImage imageNamed: foo[1]];
			dataSet.songTitle=foo[2];dataSet.mp3Name=foo[3];
			
			//eventually try to switch this to utility method?
			NSArray *fileBreakdown = [foo[4] componentsSeparatedByString: @"."];
			path = [[NSBundle mainBundle] pathForResource:fileBreakdown[0] ofType:fileBreakdown[1]];
			dataSet.bio=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
			dataSet.bandBadgeImage=foo[5];
			
			[_bandDataSets addObject:dataSet];
			
		}
		
	}
	//*** END OF GETTING BAND DATA ***
	
	// Override point for customization after application launch.
	UITabBarController *tabBarController = [[UITabBarController alloc] init];
	
	NSMutableArray *theViewControllers=[[NSMutableArray alloc] init];
	
	
	for (NSUInteger k = 0; k < [_bandDataSets count]; ++k) {
		BandData *thisBandData=[_bandDataSets objectAtIndex:k];
		ViewController *aViewController=	[[ViewController alloc]
		 initWithText: thisBandData.bandName	//apostophe, not prime
		 title: thisBandData.mp3Name
		 image: [UIImage imageNamed: thisBandData.bandBadgeImage]
		 badge: nil
											 ];
		aViewController.bandData=thisBandData;
		[theViewControllers addObject:aViewController];
		
	}
	
	tabBarController.viewControllers= [NSArray arrayWithArray:theViewControllers];
	
		
	tabBarController.selectedIndex = 0;	//0 (the leftmost one) is the default
	self.window.rootViewController = tabBarController;
	[self.window makeKeyAndVisible];
	return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
