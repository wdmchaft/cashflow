// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-
/*
 * CashFlow for iOS
 * Copyright (C) 2008-2011, Takuya Murakami, All rights reserved.
 * For conditions of distribution and use, see LICENSE file.
 */

#import "AppDelegate.h"
#import "BackupVC.h"
#import "DropboxBackup.h"
#import "WebServerBackup.h"

@implementation BackupViewController
{
    id<BackupViewDelegate> mDelegate;

    DBLoadingView *mLoadingView;
    DropboxBackup *mDropboxBackup;
}

+ (BackupViewController *)backupViewController:(id<BackupViewDelegate>)delegate
{
    BackupViewController *vc =
        [[BackupViewController alloc] initWithNibName:@"BackupView" bundle:nil];
    [vc setDelegate:delegate];
    return vc;
}

- (void)setDelegate:(id<BackupViewDelegate>)delegate
{
    mDelegate = delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[AppDelegate trackPageview:@"/BackupViewController"];
    
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
}

- (void)doneAction:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [mDelegate backupViewFinished:self];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Dropbox";

        case 1:
            return _L(@"Internal web server");
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _L(@"The backup data will be stored as CashFlowBackup.sql in root folder of Dropbox.");
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            // dropbox : sync, backup and restore
            return 3;
            
        case 1:
            // internal web backup
            return 1;
    }
    return 0;
}

// 行の内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *MyIdentifier = @"BackupViewCells";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }

    NSString *imageName = nil;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = _L(@"Sync");
                    imageName = @"dropboxSync";
                    break;
                    
                case 1:
                    //cell.textLabel.text = _L(@"Backup");
                    cell.textLabel.text = _L(@"Upload");
                    imageName = @"dropboxBackup";
                    break;
                    
                case 2:
                    //cell.textLabel.text = _L(@"Restore");
                    cell.textLabel.text = _L(@"Download");
                    imageName = @"dropboxRestore";
                    break;
            }
            break;
            
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"%@ / %@",
                                   _L(@"Backup"),
                                   _L(@"Restore")];
            break;
    }
    
    if (imageName) {
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        cell.imageView.image = [UIImage imageWithContentsOfFile:path];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    WebServerBackup *webBackup;
    UIAlertView *alertView;
    
    switch (indexPath.section) {
        case 0:
            // dropbox
            if (mDropboxBackup == nil) {
                mDropboxBackup = [[DropboxBackup alloc] init:self];
            }
            switch (indexPath.row) {
                case 0: // sync
                    [AppDelegate trackPageview:@"/BackupViewController/DropboxSync"];
                    [mDropboxBackup doSync:self];
                    break;
                    
                case 1: // backup
                    [AppDelegate trackPageview:@"/BackupViewController/DropboxBackup"];
                    [mDropboxBackup doBackup:self];
                    break;
                    
                case 2: //restore
                    [AppDelegate trackPageview:@"/BackupViewController/DropboxRestore"];
                    alertView = [[UIAlertView alloc] initWithTitle:_L(@"Warning")
                                                            message:_L(@"RestoreWarning")
                                                           delegate:self 
                                                  cancelButtonTitle:_L(@"Cancel")
                                                  otherButtonTitles:_L(@"Ok"), nil];
                    [alertView show];
                    break;
            }
            break;

        case 1:
            // internal web server
            [AppDelegate trackPageview:@"/BackupViewController/WebBackup"];
            webBackup = [[WebServerBackup alloc] init];
            [webBackup execute];
            break;
    }
}

#pragma mark UIAlertViewDelegate protocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // リストア確認
    if (buttonIndex == 1) { // OK
        // UIAlertView が消えてからすぐに次の View (LoadingView) を表示すると、
        // 次の View が正しく表示されない。このため少し待たせる
        [mDropboxBackup performSelector:@selector(doRestore:) withObject:self afterDelay:0.5];
    }
}

#pragma mark DropboxBackupDelegate

- (void)dropboxBackupStarted:(int)mode
{
    NSLog(@"DropboxBackupStarted");
    
    NSString *msg = nil;
    switch (mode) {
        case MODE_SYNC:
            msg = _L(@"Syncing");
            break;

        case MODE_BACKUP:
            msg = _L(@"Uploading");
            break;
            
        case MODE_RESTORE:
            msg = _L(@"Downloading");
            break;
    }
    mLoadingView = [[DBLoadingView alloc] initWithTitle:msg];
    mLoadingView.userInteractionEnabled = YES; // 下の View の操作不可にする
    [mLoadingView setOrientation:self.interfaceOrientation];
    [mLoadingView show];
}

- (void)dropboxBackupFinished
{
    NSLog(@"DropboxBackupFinished");
    [mLoadingView dismissAnimated:NO];
    mLoadingView = nil;
}

// 衝突が発生した場合の処理
- (void)dropboxBackupConflicted
{
    NSLog(@"DropboxBackupConflicted");
    [mLoadingView dismissAnimated:NO];
    mLoadingView = nil;
    
    UIActionSheet *as =
    [[UIActionSheet alloc] initWithTitle:_L(@"sync_conflict")
                                delegate:self
                       cancelButtonTitle:_L(@"Cancel")
                  destructiveButtonTitle:nil
                       otherButtonTitles:_L(@"Use local (upload)"), _L(@"Use remote (download)"), nil];
    [as showInView:[self view]];
}

- (void)actionSheet:(UIActionSheet*)as clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [mDropboxBackup performSelector:@selector(doBackup:) withObject:self afterDelay:0.5];
            break;
            
        case 1:
            [mDropboxBackup performSelector:@selector(doRestore:) withObject:self afterDelay:0.5];
            break;
    }
}
    
#pragma mark utils

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (IS_IPAD) return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
