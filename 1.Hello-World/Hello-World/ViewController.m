#import "ViewController.h"
#import <OpenTok/OpenTok.h>

@interface ViewController ()
<OTSessionDelegate, OTSubscriberDelegate, OTPublisherDelegate>
@end

@implementation ViewController {
    OTSession* _session;
}

static NSString* const _apiKey = @"";
static NSString* const _sessionId = @"";
static NSString* const _token = @"";

- (void)viewDidLoad
{
    [super viewDidLoad];
    _session = [[OTSession alloc] initWithApiKey:_apiKey
                                       sessionId:_sessionId
                                        delegate:self];
    [_session connectWithToken:_token error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sessionDidConnect:(OTSession*)session
{
    OTPublisher *publisher = [[OTPublisher alloc]
                              initWithDelegate:self];
    [session publish:publisher error:nil];
    [publisher.view setFrame:CGRectMake(10, 0, 400, 300)];
    [self.view addSubview:publisher.view];
}

- (void)session:(OTSession*)session
  streamCreated:(OTStream *)stream
{
    OTSubscriber *subscriber = [[OTSubscriber alloc] initWithStream:stream
                                                           delegate:self];
    [session subscribe:subscriber error:nil];
}

- (void)subscriberVideoDataReceived:(OTSubscriber *)subscriber
{
    [subscriber.view setFrame:CGRectMake(0, 300, 400, 300)];
    [self.view addSubview:subscriber.view];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
}

- (void)session:(OTSession*)session
streamDestroyed:(OTStream *)stream
{
}

- (void) session:(OTSession*)session
didFailWithError:(OTError*)error
{
}

- (void)publisher:(OTPublisherKit*)publisher
 didFailWithError:(OTError*) error
{
}

- (void)subscriberDidConnectToStream:(OTSubscriberKit*)subscriber
{
}

- (void)subscriber:(OTSubscriberKit*)subscriber
  didFailWithError:(OTError*)error
{
}

@end
