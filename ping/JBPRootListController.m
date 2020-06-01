#include "JBPRootListController.h"
#import "NSTask.h"

@implementation JBPRootListController

    - (NSArray *)specifiers {
        if (!_specifiers) {
            _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
        }
        return _specifiers;
    }

    - (void)source {
        [[UIApplication sharedApplication]
        openURL:[NSURL URLWithString:@"https://github.com"]
        options:@{}
    completionHandler:nil];
    }

    - (void)twitter {
        [[UIApplication sharedApplication]
                openURL:[NSURL URLWithString:@"https://twitter.com/JuliettePod"]
                options:@{}
      completionHandler:nil];
    }

    - (void)respring {
    // Thanks to Litten for the respring
        NSTask *t = [[NSTask alloc] init];
        [t setLaunchPath:@"/usr/bin/killall"];
        [t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
        [t launch];
    }

    - (void)setTitle {
        // Creating alert with two text fields where user can enter the app name they want to change and the replacement
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set header for a specific app." message:@"For the first field enter the app name or title that you want to change, for example Snapchat if you want to change the Snapchat title in notification center. Then in second field set the replacement, for example Snaps." preferredStyle:UIAlertControllerStyleAlert];

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"App name or title.";
            textField.secureTextEntry = NO;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Replacement";
            textField.secureTextEntry = NO;
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            NSLog(@"Nothing");
        }];

        UIAlertAction *set = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Saving
            NSString *appName = alertController.textFields[0].text;
            NSString *replacement = alertController.textFields[1].text;

            NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];

            [settings setValue:replacement forKey:appName];
            [settings writeToFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist" atomically:YES];

        }];

        [alertController addAction:cancel];
        [alertController addAction:set];

        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    - (void)setColours {
        // Creating alert with two text fields where user can enter the app name they want to change and the replacement
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set colour" message:@"255 RGB colours" preferredStyle:UIAlertControllerStyleAlert];

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"R";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"G";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];

        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"B";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];

        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            NSLog(@"Nothing");
        }];

        UIAlertAction *set = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Saving
            NSString *r = alertController.textFields[0].text;
            NSString *g = alertController.textFields[1].text;
            NSString *b = alertController.textFields[2].text;

            NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];

            [settings setValue:r forKey:@"redAmount"];
            [settings setValue:g forKey:@"greenAmount"];
            [settings setValue:b forKey:@"blueAmount"];

            [settings writeToFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist" atomically:YES];

        }];

        [alertController addAction:cancel];
        [alertController addAction:set];

        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    }

    -(void) setTitlee {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set notification list title" message:@"Set as space to set header as blank." preferredStyle:UIAlertControllerStyleAlert];

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Title";
            textField.secureTextEntry = NO;
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            NSLog(@"Nothing");
        }];

        UIAlertAction *set = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Saving
            NSString *title = alertController.textFields[0].text;
            NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];

            [settings setValue:title forKey:@"notificationsText"];
            [settings writeToFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist" atomically:YES];

        }];

        [alertController addAction:cancel];
        [alertController addAction:set];

        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    }

    - (void) marginNotification {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set notification radius" message:@"" preferredStyle:UIAlertControllerStyleAlert];

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Put in any number you want";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            NSLog(@"Nothing");
        }];

        UIAlertAction *set = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Saving
            NSString *title = alertController.textFields[0].text;
            NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];

            [settings setValue:title forKey:@"notificationRadius"];
            [settings writeToFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist" atomically:YES];

        }];

        [alertController addAction:cancel];
        [alertController addAction:set];

        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    - (void)perAppBannerColour {
        // Creating alert with two text fields where user can enter the app name they want to change and the replacement
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set colour for a specific app." message:@"255 RGB colours. This only works if you have replace notification with app name disabled. To set to reset colours have 266 be the value of the R,G, and B options." preferredStyle:UIAlertControllerStyleAlert];

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"App name";
            textField.secureTextEntry = NO;
        }];

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"R";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"G";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];

        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"B";
            textField.secureTextEntry = NO;
            [textField setKeyboardType:UIKeyboardTypeNumberPad];

        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            NSLog(@"Nothing");
        }];

        UIAlertAction *set = [UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Saving
            NSString *appName = alertController.textFields[0].text;
            // Needs to be upper case for some reason
            appName = [appName uppercaseString];

            NSString *r = alertController.textFields[1].text;
            NSString *g = alertController.textFields[2].text;
            NSString *b = alertController.textFields[3].text;

            NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];
            [settings setValue:r forKey:[NSString stringWithFormat:@"redAmount%@", appName]];
            [settings setValue:g forKey:[NSString stringWithFormat:@"greenAmount%@", appName]];
            [settings setValue:b forKey:[NSString stringWithFormat:@"blueAmount%@", appName]];

            [settings writeToFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist" atomically:YES];

        }];

        [alertController addAction:cancel];
        [alertController addAction:set];

        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    }
@end
