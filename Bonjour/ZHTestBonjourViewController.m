//
//  ZHTestBonjourViewController.m
//  AppDemo
//
//  Created by TerryChao on 2017/2/9.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHTestBonjourViewController.h"

#define ZH_Domain @"local."
#define ZH_Service_Type @"_witap2._tcp."

typedef void (^myBlock)(void);

@interface ZHTestBonjourViewController () <NSNetServiceDelegate, NSNetServiceBrowserDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *tableviewHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *serviceInfoLabel;

@property (nonatomic, strong) NSNetService *service;

@property (nonatomic, strong) NSMutableArray *services;                       // of NSNetService, sorted by name
@property (nonatomic, strong) NSNetServiceBrowser *browser;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, assign) myBlock mb;

@end



@implementation ZHTestBonjourViewController

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Bonjour";
    
    self.tableview.tableHeaderView = self.tableviewHeaderView;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor redColor];
    
    self.serviceInfoLabel.text = @"Opening...";
    
    static int i = 0;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        ZHLog(@"timer=%d", i++);
        weakSelf.timeString = [NSString stringWithFormat:@"%d", i];
    }];
    
    self.mb = ^{
//        self.timeString = @"dfdf";
//        self.service = [[NSNetService alloc] initWithDomain:ZH_Domain type:ZH_Service_Type name:[UIDevice currentDevice].name port:0];
    };
    self.mb();
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:)  userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime:(id)sender
{
    
}

- (void)initService
{
    self.service = [[NSNetService alloc] initWithDomain:ZH_Domain type:ZH_Service_Type name:[UIDevice currentDevice].name port:0];
    self.service.includesPeerToPeer = YES;
    self.service.delegate = self;
    [self.service publishWithOptions:NSNetServiceListenForConnections];
}


- (void)startBrowser
{
    assert([self.services count] == 0);
    
    assert(self.browser == nil);
    
    self.browser = [[NSNetServiceBrowser alloc] init];
    self.browser.includesPeerToPeer = YES;
    [self.browser setDelegate:self];
    [self.browser searchForServicesOfType:ZH_Service_Type inDomain:@"local"];
}

- (void)stopBrowser
{
    [self.browser stop];
    self.browser = nil;
    
    [self.services removeAllObjects];
}

- (IBAction)openServiceClick:(id)sender {
    [self initService];
}

- (IBAction)closeServiceClick:(id)sender {
}

- (IBAction)serachServiceClick:(id)sender {
    [self startBrowser];
}

- (IBAction)stopSearchServiceClick:(id)sender {
}

#pragma mark - NSNetServiceDelegate

- (void)netServiceWillPublish:(NSNetService *)sender
{
    ZHLog(@"netServiceWillPublish sender=%@", sender);
}

- (void)netServiceDidPublish:(NSNetService *)sender
{
    ZHLog(@"netServiceDidPublish sender=%@", sender);
}

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *, NSNumber *> *)errorDict
{
    ZHLog(@"netService:didNotPublish: sender=%@, errorDict=%@", sender, errorDict);
}

/* Sent to the NSNetService instance's delegate prior to resolving a service on the network. If for some reason the resolution cannot occur, the delegate will not receive this message, and an error will be delivered to the delegate via the delegate's -netService:didNotResolve: method.
 */
- (void)netServiceWillResolve:(NSNetService *)sender
{
    ZHLog(@"netServiceWillResolve sender=%@", sender);
}

/* Sent to the NSNetService instance's delegate when one or more addresses have been resolved for an NSNetService instance. Some NSNetService methods will return different results before and after a successful resolution. An NSNetService instance may get resolved more than once; truly robust clients may wish to resolve again after an error, or to resolve more than once.
 */
- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
    ZHLog(@"netServiceDidResolveAddress sender=%@", sender);
}

/* Sent to the NSNetService instance's delegate when an error in resolving the instance occurs. The error dictionary will contain two key/value pairs representing the error domain and code (see the NSNetServicesError enumeration above for error code constants).
 */
- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *, NSNumber *> *)errorDict
{
    ZHLog(@"netService:didNotResolve: sender=%@, errorDict=%@", sender, errorDict);
}

/* Sent to the NSNetService instance's delegate when the instance's previously running publication or resolution request has stopped.
 */
- (void)netServiceDidStop:(NSNetService *)sender
{
    ZHLog(@"netServiceDidStop sender=%@", sender);
}

/* Sent to the NSNetService instance's delegate when the instance is being monitored and the instance's TXT record has been updated. The new record is contained in the data parameter.
 */
- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data
{
    ZHLog(@"netService:didUpdateTXTRecordData: sender=%@, data=%@", sender, data);
}


/* Sent to a published NSNetService instance's delegate when a new connection is
 * received. Before you can communicate with the connecting client, you must -open
 * and schedule the streams. To reject a connection, just -open both streams and
 * then immediately -close them.
 
 * To enable TLS on the stream, set the various TLS settings using
 * kCFStreamPropertySSLSettings before calling -open. You must also specify
 * kCFBooleanTrue for kCFStreamSSLIsServer in the settings dictionary along with
 * a valid SecIdentityRef as the first entry of kCFStreamSSLCertificates.
 */
- (void)netService:(NSNetService *)sender didAcceptConnectionWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream
{
    ZHLog(@"netService:didAcceptConnectionWithInputStream:outputStream: sender=%@", sender);
}


#pragma mark - NSNetServiceBrowserDelegate

/* Sent to the NSNetServiceBrowser instance's delegate before the instance begins a search. The delegate will not receive this message if the instance is unable to begin a search. Instead, the delegate will receive the -netServiceBrowser:didNotSearch: message.
 */
- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)browser
{
    ZHLog(@"netServiceBrowserWillSearch sender=%@", browser);
}

/* Sent to the NSNetServiceBrowser instance's delegate when the instance's previous running search request has stopped.
 */
- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser
{
    ZHLog(@"netServiceBrowserDidStopSearch sender=%@", browser);
}

/* Sent to the NSNetServiceBrowser instance's delegate when an error in searching for domains or services has occurred. The error dictionary will contain two key/value pairs representing the error domain and code (see the NSNetServicesError enumeration above for error code constants). It is possible for an error to occur after a search has been started successfully.
 */
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *, NSNumber *> *)errorDict
{
    ZHLog(@"netServiceBrowser:didNotSearch: browser=%@, errorDict=%@", browser, errorDict);
}

/* Sent to the NSNetServiceBrowser instance's delegate for each domain discovered. If there are more domains, moreComing will be YES. If for some reason handling discovered domains requires significant processing, accumulating domains until moreComing is NO and then doing the processing in bulk fashion may be desirable.
 */
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing
{
    ZHLog(@"netServiceBrowser:didFindDomain:moreComing: browser=%@, domainString=%@, moreComing=%d", browser, domainString, moreComing);
}

/* Sent to the NSNetServiceBrowser instance's delegate for each service discovered. If there are more services, moreComing will be YES. If for some reason handling discovered services requires significant processing, accumulating services until moreComing is NO and then doing the processing in bulk fashion may be desirable.
 */
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing
{
    ZHLog(@"netServiceBrowser:didFindService:moreComing: browser=%@, service=%@, moreComing=%d", browser, service, moreComing);
}

/* Sent to the NSNetServiceBrowser instance's delegate when a previously discovered domain is no longer available.
 */
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing
{
    ZHLog(@"netServiceBrowser:didRemoveDomain:moreComing: browser=%@, domainString=%@, moreComing=%d", browser, domainString, moreComing);
}

/* Sent to the NSNetServiceBrowser instance's delegate when a previously discovered service is no longer published.
 */
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing
{
    ZHLog(@"netServiceBrowser:didRemoveService:moreComing: browser=%@, service=%@, moreComing=%d", browser, service, moreComing);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"line%ld", indexPath.row];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"detail%ld", indexPath.row];
    
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZH_TABLEVIEWCELL_ID];
    [cell setBackgroundColor:[UIColor redColor]];
    cell.title = [NSString stringWithFormat:@"detail%ld", indexPath.row];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
