//
//  HikeSearchResultsViewController.m
//  Hikes
//
//  Created by theraju on 11/12/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import "HikeSearchResultsViewController.h"
#import "HikeDataController.h"
#import "Hike.h"

@implementation HikeSearchResultsViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    self.hikeDataController = [[HikeDataController alloc] init];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.hikeDataController clear];
    NSMutableString *urlString = [NSMutableString stringWithString:@"http://192.168.42.116:3000/trail/search?"];
    BOOL isFirst = TRUE;
    if (self.hikeSearchCriteria.distanceLessThan > 0) {
        [urlString appendFormat: @"roundtriplte=%d", self.hikeSearchCriteria.distanceLessThan];
        isFirst = FALSE;
    }
    
    if (self.hikeSearchCriteria.elevationGainLessThan > 0) {
        if (isFirst == FALSE)
        {
            [urlString appendString: @"&"];
        }
        
        [urlString appendFormat: @"elevgain=%d", self.hikeSearchCriteria.elevationGainLessThan];
        isFirst = FALSE;
    }
    NSURL *url = [NSURL URLWithString: [NSString stringWithString: urlString]];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: url];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSArray* jsonArray = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    //populate hikeDataController
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for(NSDictionary *item in jsonArray) {
            Hike *hike = [[Hike alloc] initWithName:[item objectForKey:@"title"] distance:[(NSString *)[item objectForKey:@"round_trip"] floatValue] elevation:[(NSString *)[item objectForKey:@"elevation_gain"] intValue]];
            [self.hikeDataController addHike:hike];
        }
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.hikeDataController.countOfList;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchResult";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Hike *hike = [self.hikeDataController objectInListAtIndex:indexPath.row];
    [cell.textLabel setText:hike.name];
    NSString *subTitle = [NSString stringWithFormat: @"%.02f miles, %d feet", hike.distance, hike.elevation];
    [cell.detailTextLabel setText:subTitle];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"Search Results";
}

- (void)setSearchCriteria:(HikeSearchCriteria *)searchCriteria
{
    self.hikeSearchCriteria = searchCriteria;
}
@end
