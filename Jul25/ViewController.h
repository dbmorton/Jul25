

#import <UIKit/UIKit.h>
#import "BandData.h"

@interface ViewController: UIViewController {
	NSString *text;
}

- (id) initWithText: (NSString *) t
			  title: (NSString *) title
			  image: (UIImage *) image
			  badge: (NSString *) badge;

@property (nonatomic, copy) IBOutlet NSString *text;

//holds the band datasets we transtion between
@property (strong, nonatomic) BandData *bandData;

@end
