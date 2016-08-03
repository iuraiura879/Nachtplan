//
//  HttpApi.m
//


//http://nachtplan.pixelutions.de/index.php?lo=API&pa=dhJ$jid_D&tu=&pla=0&api=detail_event&id=%@&date=2014-02-27&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f
//
//http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f&user=API&pass=520971a4f40360fb60cca4fc6871b3a9
//
//http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&page=2&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f&user=API&pass=520971a4f40360fb60cca4fc6871b3a9
//
//http://nachtplan.pixelutions.de/index.php?api=list_event&search_text=%@&date=2014-02-27&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f&user=API&pass=520971a4f40360fb60cca4fc6871b3a9
//
//
//http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&page=2&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f&user=API&pass=520971a4f40360fb60cca4fc6871b3a9
//
//http://nachtplan.pixelutions.de/index.php?lo=API&pa=dhJ$jid_D&tu=&pla=0&api=detail_event&id=483&date=2014-02-27&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f
//
//http://nachtplan.pixelutions.de/index.php?api=list_event&search_text=depeche&date=2014-02-27&serial=d54fcb19aa615be716bbb912be8989add6e7fe2f&user


#import "HttpApi.h"

@implementation HttpApi
static HttpApi *httpApi;

+ (HttpApi*) GetAPIs
{
    if(httpApi == nil)
    {
        httpApi = [[HttpApi alloc] init];
    }
    return httpApi;
}

#pragma mark SendRequest
- (id) sendRequest:(NSString *)strAddress With:(id)requestData
{

    NSError *error = nil;
    NSURLResponse *response;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", strAddress, LogInData]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSLog(@"*** URL: %@ ***" , url );
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:requestData];
    
    NSData *responseData = [NSURLConnection
                            sendSynchronousRequest: urlRequest
                            returningResponse: &response
                            error: &error ];
    
    if ([responseData length] >0 && error == nil)
    {
        NSLog(@"Receive Success!");
        return responseData;
    }
    else if ([responseData length] == 0 && error == nil)
    {
        NSLog(@"Nothing was downloaded.");
    }
    else if (error != nil)
    {
        NSLog(@"Error happened = %@", error);
    }
    return nil;

}

@end
