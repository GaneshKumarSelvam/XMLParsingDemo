//
//  ViewController.h
//  XMLRetrievingApps
//
//  Created by Student on 25/05/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *countrySC;

@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySC;
- (IBAction)onClickOfProceedButton:(UIButton *)sender;
@property NSXMLParser * xmlParser;
@property NSURLRequest * getURLReq;
@property NSURLSessionDataTask * sessionDataTask;

@property NSURLSession * urlSession;
@property NSMutableDictionary * serverData;
@property NSMutableArray * titleArray;
@property NSMutableArray * imageArray;
@property NSMutableArray * summaryArray;
@property BOOL entry;
@property NSString * titleOfApp;
@property NSString * imageLink;

@property NSString * summaryString;

@property NSMutableString * currentElementValueSummary;
@property NSMutableString * currentElementValueTitle;
@property NSString * name;



@property int i;

@end

