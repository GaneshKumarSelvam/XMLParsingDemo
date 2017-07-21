//
//  AppDescriptionViewController.h
//  XMLRetrievingApps
//
//  Created by Student on 25/05/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDescriptionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;

@property (weak, nonatomic) IBOutlet UILabel *appLabel;
@property (weak, nonatomic) IBOutlet UITextView *appSummaryTV;

@property NSString * appName;
@property NSString * appSummary;
@property NSString * imgString;
@property NSString * newappsummary;

@end
