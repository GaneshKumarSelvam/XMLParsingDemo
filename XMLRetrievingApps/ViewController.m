//
//  ViewController.m
//  XMLRetrievingApps
//
//  Created by Student on 25/05/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ViewController.h"
#import "AppsTableViewController.h"

@interface ViewController ()

@end
AppsTableViewController * appTV;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // self.xmlParser.delegate=self;
    

    appTV=[[AppsTableViewController alloc]init];
    self.titleArray=[[NSMutableArray alloc]init];
    
    
    self.imageArray=[[NSMutableArray alloc]init];
    self.summaryArray=[[NSMutableArray alloc]init];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickOfProceedButton:(UIButton *)sender{
    if ((self.countrySC.selectedSegmentIndex==0||self.countrySC.selectedSegmentIndex==1||self.countrySC.selectedSegmentIndex==2)&&(self.categorySC.selectedSegmentIndex==0||self.categorySC.selectedSegmentIndex==1||self.categorySC.selectedSegmentIndex==2)) {
       [self.titleArray removeAllObjects];
        [self.imageArray removeAllObjects];
        [self.summaryArray removeAllObjects];

        
        if (self.countrySC.selectedSegmentIndex==0&&self.categorySC.selectedSegmentIndex==0) {
            
            self.getURLReq=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/in/rss/topfreeapplications/limit=25/xml"]];
            
            
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==0&&self.categorySC.selectedSegmentIndex==1)
        {
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/in/rss/toppaidapplications/limit=25/xml"]];
            
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==0&&self.categorySC.selectedSegmentIndex==2)
        {
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/in/rss/newfreeapplications/limit=25/xml"]];
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==1&&self.categorySC.selectedSegmentIndex==0)
        {
            
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=25/xml"]];
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==1&&self.categorySC.selectedSegmentIndex==1)
        {
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/us/rss/toppaidapplications/limit=25/xml"]];
            
            
        }else if (self.countrySC.selectedSegmentIndex==1&&self.categorySC.selectedSegmentIndex==2)
        {
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/us/rss/newfreeapplications/limit=25/xml"]];
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==2&&self.categorySC.selectedSegmentIndex==0)
        {
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/gb/rss/topfreeapplications/limit=25/xml"]];
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==2&&self.categorySC.selectedSegmentIndex==1)
        {
            
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/gb/rss/toppaidapplications/limit=25/xml"]];
            
            
        }
        else if (self.countrySC.selectedSegmentIndex==2&&self.categorySC.selectedSegmentIndex==2)
        {
            
            
            self.getURLReq=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://itunes.apple.com/gb/rss/newfreeapplications/limit=25/xml"]];
            
            
        }
        
        
        self.urlSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        self.sessionDataTask=[self.urlSession dataTaskWithRequest:self.getURLReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            self.xmlParser=[[NSXMLParser alloc]initWithData:data];
             [self.xmlParser setDelegate:self];
            [self.xmlParser parse];

           
     
            [appTV.tableView reloadData];
            
            
        }];
        
        [self.sessionDataTask resume];

        
        
    }
    else{
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Select Both Segments" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    if (self.categorySC.selectedSegmentIndex==2) {
        //[self.summaryArray removeAllObjects];
        if ([elementName isEqualToString:@"im:name"]) {
            self.titleOfApp=elementName;
            //////NSLog(@"%@",elementName);
            
        }
        else if ([elementName isEqualToString:@"im:image"]) {
            self.imageLink=elementName;
        }
        else if ([elementName isEqualToString:@"title"]){
            self.name=elementName;
        }

    }
    else{
        if ([elementName isEqualToString:@"im:name"]) {
            self.titleOfApp=elementName;
            //////NSLog(@"%@",elementName);
            
        }
        else if ([elementName isEqualToString:@"im:image"]) {
            self.imageLink=elementName;
        }
        else if ([elementName isEqualToString:@"summary"]){
            self.summaryString=elementName;
        }

        
    }
   }
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    if (self.categorySC.selectedSegmentIndex==2) {
        if ([self.titleOfApp isEqualToString:@"im:name"]) {
            
            if (!self.currentElementValueTitle) {
                self.currentElementValueTitle=[[NSMutableString alloc]initWithString:string];
            }
            else{
                [self.currentElementValueTitle appendString:string];
            }
            
        }
        else if ([self.imageLink isEqualToString:@"im:image"]) {
            
            if([string hasSuffix:@"53x53bb-85.png"]){
                [self.imageArray addObject:string];
            }
            
        }
        else if ([self.name isEqualToString:@"title"]) {
            
            if (!self.currentElementValueSummary) {
                self.currentElementValueSummary=[[NSMutableString alloc]initWithString:string];
            }
            else{
                [self.currentElementValueSummary appendString:string];
            }
        }

    }
    else{
       if ([self.titleOfApp isEqualToString:@"im:name"]) {
           
           if (!self.currentElementValueTitle) {
               self.currentElementValueTitle=[[NSMutableString alloc]initWithString:string];
           }
           else{
               [self.currentElementValueTitle appendString:string];
           }
        
        }
    else if ([self.imageLink isEqualToString:@"im:image"]) {
        
        if([string hasSuffix:@"53x53bb-85.png"]){
            [self.imageArray addObject:string];
          }
        
    }
    else if ([self.summaryString isEqualToString:@"summary"]) {
        
        if (!self.currentElementValueSummary) {
            self.currentElementValueSummary=[[NSMutableString alloc]initWithString:string];
        }
        else{
            [self.currentElementValueSummary appendString:string];
        }
      }
    }
    self.imageLink=nil;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if (self.categorySC.selectedSegmentIndex==2) {
        if ([elementName isEqualToString:@"im:name"]) {
            self.titleOfApp=nil;
            [self.titleArray addObject:self.currentElementValueTitle];
            self.currentElementValueTitle=nil;
            ////NSLog(@"%@",self.titleArray);
        }
        else if ([elementName isEqualToString:@"title"]) {
            self.name=nil;
            [self.summaryArray addObject:self.currentElementValueSummary];
            //[self.summaryArray removeObjectAtIndex:0];
            self.currentElementValueSummary=nil;
            ////NSLog(@"%@",self.summaryArray);
        }

    }
    else{
    
    
    if ([elementName isEqualToString:@"im:name"]) {
        self.titleOfApp=nil;
        [self.titleArray addObject:self.currentElementValueTitle];
        self.currentElementValueTitle=nil;
        ////NSLog(@"%@",self.titleArray);
    }
       else if ([elementName isEqualToString:@"summary"]) {
        self.summaryString=nil;
        [self.summaryArray addObject:self.currentElementValueSummary];
        self.currentElementValueSummary=nil;
    }
    }
    
  }
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    appTV = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"hello"]) {
        
        appTV.titleOnCellArray=self.titleArray;
        appTV.imageOnCellArray=self.imageArray;
        appTV.summaryData=self.summaryArray;
        

    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (self.categorySC.selectedSegmentIndex==2)
    {
        [self.summaryArray removeObjectAtIndex:0];
    }
//    NSLog(@"Count %lu",self.summaryArray.count);
//    NSLog(@"Count %lu",self.titleArray.count);

}

@end
