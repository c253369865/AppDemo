/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The table view controller responsible for displaying the filtered products as the user types in the search field.
 */

#import "APLResultsTableController.h"
#import "APLProduct.h"
#import "ZHTestModel.h"

@implementation APLResultsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
   [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:nil] forCellReuseIdentifier:ZH_TABLEVIEWCELL_ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredProducts.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    
//    APLProduct *product = self.filteredProducts[indexPath.row];
//    [self configureCell:cell forProduct:product];
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTestModel *model = self.self.filteredProducts[indexPath.row];
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZH_TABLEVIEWCELL_ID];
    [cell setBackgroundColor:[UIColor redColor]];
    cell.title = model.title;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHTestModel *model = self.self.filteredProducts[indexPath.row];
    
    if (model.methodName) {
        SEL sel = NSSelectorFromString(model.methodName);
        if ([self respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:sel];
#pragma clang diagnostic pop
        }
    }
    else if (model.className) {
        ZHViewController *viewController = [[NSClassFromString(model.className) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        
        switch (model.showViewStyle) {
            case ZHTestModelShowViewStylePush:
                [self.navigationController pushViewController:viewController animated:YES];
                break;
            case ZHTestModelShowViewStylePresent:
                [self presentViewController:viewController animated:YES completion:nil];
                break;
        }
    }
}


@end
