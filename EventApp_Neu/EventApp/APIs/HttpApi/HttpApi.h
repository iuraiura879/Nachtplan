//
//  HttpApi.h
//

#import <Foundation/Foundation.h>

#define AllEvents_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date"  // yyyy-mm-dd  date_to / date_from
#define LogInData @"&user=API&pass=520971a4f40360fb60cca4fc6871b3a9"
#define DateString @"&date_to=%@&date_from=%@"
#define SearchByText_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&search_text="
#define SearchByDate_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&search_date="
#define EventDetail_Address @"http://nachtplan.pixelutions.de/index.php?api=detail_event&id="
#define Location_Address @"http://nachtplan.pixelutions.de/index.php?api=list_venue"//&latitude=51.2167&longitude=6.8104&radius=50"

#define PartyType_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&search_event_group_id=2"
#define LiveType_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&search_event_group_id=4"
#define FestivalType_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&search_event_group_id=1"
#define KulturType_Address @"http://nachtplan.pixelutions.de/index.php?api=list_event_date&search_date=new&search_event_group_id=3"

#define FeedBack_Address @"feedback@nachtplanapp.com"
#define FaceBook_Address @"https://www.facebook.com/nachtplan"
#define Twitter_Address @"https://twitter.com/nachtplan"

@interface HttpApi : NSObject
+ (HttpApi*) GetAPIs;
- (id) sendRequest:(NSString *)strAddress With:(id)requestData;
@end
