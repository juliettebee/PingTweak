#import <UIKit/UIKit.h>

@interface NCNotificationListHeaderTitleView : UIView
    @property (nonatomic,copy) NSString * title;
@end

@interface NCNotificationShortLookView : UIView
    @property (nonatomic,copy) NSString * title;
    @property (nonatomic,copy) NSString * primaryText;
    @property (nonatomic,copy) NSString * primarySubtitleText;
    @property (nonatomic,copy) NSString * secondaryText;
@end

int red = 0;
int green = 0;
int blue = 0;
NSString* title = @"";
int radius = 25;
NSDictionary *settings;
BOOL titleChange;
BOOL noTop;
BOOL noBottom;


@interface NCToggleControl : UIView
    @property (nonatomic,copy) NSString * title;
@end


@interface NCNotificationListCell : UIView
@end

@interface NCNotificationViewController : UIViewController
    @property (assign,nonatomic) BOOL hasShadow;                                                                                                                                                                                 //@synthesize hasShadow=_hasShadow - In the implementation block
@end

@interface _NCNotificationShortLookScrollView : UIScrollView
@end

@interface PLPlatterCustomContentView : UIView
@end

@interface PLPlatterHeaderContentView : UIView
@end

@interface NCNotificationListCellActionButton : UIControl
@end

@interface _UIMappedBitmapImage : UIImage
@end