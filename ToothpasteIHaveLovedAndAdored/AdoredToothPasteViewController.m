//
//  ViewController.m
//  ToothpasteIHaveLovedAndAdored
//
//  Created by Ronald Hernandez on 3/26/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "AdoredToothPasteViewController.h"
#import "ToothpastesViewController.h"

@interface AdoredToothPasteViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *adoredToothPastes;

@end

@implementation AdoredToothPasteViewController

NSString *const kUserDefaultsDate = @"theDate";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.adoredToothPastes = [NSMutableArray new];
     [self load];

}
-(void)viewWillAppear:(BOOL)animated{
    //[self load];
}
-(void)viewDidAppear:(BOOL)animated{

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adoreToothpasteCell"];
    cell.textLabel.text = self.adoredToothPastes[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.adoredToothPastes.count;
}
-(NSURL *)getPlist{

    return [[self documentDirectory] URLByAppendingPathComponent:@"pastes.plist"];
}

-(NSURL *) documentDirectory{

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]firstObject];
}
-(void)save{



    [self.adoredToothPastes writeToURL:[self getPlist] atomically:YES];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:@"theDate"];
    [userDefaults synchronize];

}
-(void)load{


    self.adoredToothPastes = [NSMutableArray arrayWithContentsOfURL:[self getPlist]]  ?: [NSMutableArray new];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *datefromDefaults = [defaults objectForKey:@"theDate"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM dd, yy HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:datefromDefaults];

    return dateString;
}

-(IBAction)unwindFromAddToothpasteVC:(UIStoryboardSegue *)segue{

    ToothpastesViewController *toothpasteVC = segue.sourceViewController;
    [self.adoredToothPastes addObject:[toothpasteVC adoredToothpaste]];
     [self save];
    [self.tableView reloadData];


}


@end
