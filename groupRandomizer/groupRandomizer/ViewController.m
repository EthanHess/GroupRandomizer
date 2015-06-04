//
//  ViewController.m
//  groupRandomizer
//
//  Created by Ethan Hess on 5/29/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "NameController.h"
#import "Name.h"

static int numberOfPeopleInGroup = 2;

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *randomizeButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat screenHeight;
@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic,assign) NSInteger arrayIndex;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float cornerRadius = self.addButton.frame.size.height / 2;
    
    self.addButton.layer.cornerRadius = cornerRadius;
    self.randomizeButton.layer.cornerRadius = cornerRadius;
    self.twoButton.layer.cornerRadius = cornerRadius;
    self.threeButton.layer.cornerRadius = cornerRadius;
    self.fourButton.layer.cornerRadius = cornerRadius;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

}

- (IBAction)addName:(id)sender {
    
    [[NameController sharedInstance]addNameWithNameString:self.textField.text];
    
    [self.collectionView reloadData];
    
}

- (IBAction)randomize:(id)sender {
    
    [[NameController sharedInstance]shuffle:[NameController sharedInstance].names];
    
    [self.collectionView reloadData]; 
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int screenWidth = self.view.frame.size.width;
    
    CGSize circleSize = CGSizeMake(screenWidth / 4, screenWidth / 4);
    
    return circleSize;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CGSize itemSize = CGSizeMake((_screenWidth /numberOfPeopleInGroup) - 6 , ((_screenHeight - 64) / 5) / 2);
//    return itemSize;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [NameController sharedInstance].names.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Name *name = [[NameController sharedInstance].names objectAtIndex:indexPath.item];
    
    cell.nameLabel.text = name.nameString;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Name?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        Name *name = [[NameController sharedInstance].names objectAtIndex:indexPath.item];
        
        [[NameController sharedInstance]removeName:name];
        
        [collectionView reloadData];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}




@end
