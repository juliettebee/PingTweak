#import "ping.h"
#import <AudioToolbox/AudioServices.h>
BOOL enabled;


%group ping
    %hook NCNotificationShortLookView
    - (void)layoutSubviews {
        NSString *titlee = self.primaryText;
        NSString *appName = self.title;

        // Checking if there's content in title, if not leaving default
        if (titleChange) {
                if ([titlee length] == 0) {

                } else {
                    self.title = titlee;
                }
                if ([self.secondaryText length] <= 2) {
                    self.secondaryText = @"";
                }
        }
        %orig;
        // Setting background colour
        NSArray<__kindof UIView *> *subs = self.subviews;
        UIView *transparent = subs[0];
        [transparent setHidden:YES];
        self.layer.cornerRadius = radius;

        self.primaryText = @"";

        int onTop = 1;

        // Getting user defined per app notification colour
        int thisred = [[settings objectForKey:[NSString stringWithFormat:@"redAmount%@", appName]] ?: @266 intValue];
        int thisgreen = [[settings objectForKey:[NSString stringWithFormat:@"greenAmount%@", appName]] ?: @266 intValue];
        int thisblue = [[settings objectForKey:[NSString stringWithFormat:@"blueAmount%@", appName]] ?: @266 intValue];
        // then checking if they're null (equal or above 266)
        if (thisred <= 255 && thisgreen <= 255 && thisblue <= 255) {
                    red = thisred;
                    green = thisgreen;
                    blue = thisblue;
                }
        // Setting notification colour

        for (UIView *sub in subs) {
            if (onTop == 2) {
                // Setting upper radius
                UIBezierPath *maskPath;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:sub.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight |UIRectCornerTopLeft)
                                                       cornerRadii:CGSizeMake(radius, radius)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =sub.bounds;
                maskLayer.path = maskPath.CGPath;
                sub.layer.mask = maskLayer;
                sub.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.00];
            } else {
                // Setting bottom radius
                UIBezierPath *maskPath;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:sub.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(radius, radius)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = sub.bounds;
                maskLayer.path = maskPath.CGPath;
                sub.layer.mask = maskLayer;
                sub.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.00];
            }
            onTop = onTop + 1;
        }
        red = [[settings objectForKey:@"redAmount"] ?: @39 intValue];
        green = [[settings objectForKey:@"greenAmount"] ?: @52 intValue];
        blue = [[settings objectForKey:@"blueAmount"] ?: @65 intValue];
    }
    %end

    // TODO: Add per app titles

    // Changing the notifications text
    %hook NCNotificationListHeaderTitleView
        - (void)layoutSubviews {
            %orig;
            // Checking if it's an app name
            UIView *parent = self.superview.superview.superview.superview.superview.superview;
            NSString *description = parent.description;
            NSString *newTitle = [settings valueForKey:self.title];
            if ([description containsString:@"<CSMainPageView"]) {
                self.title = title;
            } else {
                // Then checking if the user has defined a custom title, if they have set the title to that.
                if (newTitle == nil) {
                } else {
                    // Setting text with out Ellipsis
                    UILabel *t = self.subviews[0].subviews[0];
                    t.text = newTitle;
                    t.minimumScaleFactor = 8./t.font.pointSize;
                    t.adjustsFontSizeToFitWidth = YES;
                }
            }
        }
    %end

    // Removing shadow in popup

    %hook NCNotificationViewController
        - (void)viewDidLoad {
            %orig;
            self.hasShadow = false;
        }
    %end

    // Changing action cell colour

    %hook NCNotificationListCellActionButton
        - (void)layoutSubviews {
            UIView *actionButton = self.subviews[0];
            actionButton.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.00];
            // Need to do it first or it flickers in
            %orig;
        }
    %end
%end

%ctor {
    // Getting preferences and seeing if tweak is enabled
    // And setting defaults
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];
    BOOL enabled = [[settings objectForKey:@"enableTweak"] ?: @(YES) boolValue];
    titleChange = [[settings objectForKey:@"enableTitleChange"] ?: @(YES) boolValue];
    radius = [[settings objectForKey:@"notificationRadius"] ?: @10 intValue];
    red = [[settings objectForKey:@"redAmount"] ?: @39 intValue];
    green = [[settings objectForKey:@"greenAmount"] ?: @52 intValue];
    blue = [[settings objectForKey:@"blueAmount"] ?: @65 intValue];
    title = [NSString stringWithFormat:@"%@", [[settings valueForKey:@"notificationsText"] ?: @"Notifications" stringValue] ];
    if (enabled) {
        %init(ping);
    }
}