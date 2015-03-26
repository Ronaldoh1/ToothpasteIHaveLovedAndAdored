//
//  ToothPasteViewController.m
//  ToothpasteIHaveLovedAndAdored
//
//  Created by Ronald Hernandez on 3/26/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ToothpastesViewController.h"

@interface ToothpastesViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *toothPastes;

@end

@implementation ToothpastesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // self.toothPastes = [NSArray new];
    

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://methylblue.com/MM/toothpastes.json"]];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.toothPastes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.tableView reloadData];
    }];


}

-(NSString *)adoredToothpaste{
    NSInteger row = self.tableView.indexPathForSelectedRow.row;
    return self.toothPastes[row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toothpasteCell"];
    cell.textLabel.text = self.toothPastes[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.toothPastes.count
    ;
}



@end