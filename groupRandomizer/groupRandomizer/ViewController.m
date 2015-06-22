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

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *randomizeButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat screenHeight;
@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic,assign) NSInteger arrayIndex;
@property (nonatomic,assign) NSInteger numberOfPeopleInGroup;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (nonatomic, strong) NSArray *arrayOfStudents;
@end

@implementation ViewController

@synthesize screenHeight, screenWidth;

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.numberOfPeopleInGroup = 2;
    self.arrayOfStudents = [[NSArray alloc]initWithArray:[NameController sharedInstance].names];

    float cornerRadius = self.addButton.frame.size.height / 2;
    
    screenHeight = self.view.frame.size.height;
    screenWidth = self.view.frame.size.width;
    
    self.addButton.layer.cornerRadius = cornerRadius;
    self.randomizeButton.layer.cornerRadius = cornerRadius;
    self.twoButton.layer.cornerRadius = cornerRadius;
    self.threeButton.layer.cornerRadius = cornerRadius;
    self.fourButton.layer.cornerRadius = cornerRadius;
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (IBAction)addName:(id)sender {
    
    [[NameController sharedInstance]addNameWithNameString:self.textField.text];
    self.arrayOfStudents = [[NSArray alloc]initWithArray:[NameController sharedInstance].names];
    self.textField.text = @"";
    
    [self.collectionView reloadData];
    
}

- (IBAction)randomize:(id)sender {
    
    self.arrayOfStudents = [[NameController sharedInstance]shuffle:[NameController sharedInstance].names];
    
    [self.collectionView reloadData]; 
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize itemSize = CGSizeMake((screenWidth /self.numberOfPeopleInGroup) - 10 , ((screenHeight - 64) / 5) / 2);
    
    return itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Name *name = [self.arrayOfStudents objectAtIndex:indexPath.item];
    
    cell.nameLabel.text = name.nameString;
    
    cell.nameLabel.frame = cell.bounds;
    
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrayOfStudents.count;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Name?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        Name *name = [self.arrayOfStudents objectAtIndex:indexPath.item];
        
        [[NameController sharedInstance]removeName:name];
        self.arrayOfStudents = [[NSArray alloc]initWithArray:[NameController sharedInstance].names];

        [collectionView reloadData];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (IBAction)groupsOfTwo:(id)sender {
    
    self.numberOfPeopleInGroup = 2;
    [self.collectionView reloadData];
    
}

- (IBAction)groupsOfThree:(id)sender {
    
    self.numberOfPeopleInGroup = 3;
    [self.collectionView reloadData];
    
}

- (IBAction)groupsOfFour:(id)sender {
    
    self.numberOfPeopleInGroup = 4;
    [self.collectionView reloadData];
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}





@end


