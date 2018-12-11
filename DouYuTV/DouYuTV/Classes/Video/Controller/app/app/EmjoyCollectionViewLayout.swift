//
//  EmjoyCollectionViewLayout.swift
//  app
//
//  Created by 单琦 on 2018/5/31.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class EmjoyCollectionViewLayout: UICollectionViewFlowLayout {
    var numRow:Int = 0;//行数
    var numCol:Int = 0;//列数
    var contentInsets: UIEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 0)
    //所有cell的布局属性
    var layoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
    
    override init() {
        super.init();
        self.itemSize = CGSize(width: 50, height: 50);
        self.scrollDirection = .horizontal
        self.numRow = 7;
        self.numCol = 4;
        self.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //计算布局
    override func prepare() {
        
        let numsection = self.collectionView!.numberOfSections;
        let itemNum: Int = self.collectionView!.numberOfItems(inSection: 0)
        layoutAttributes.removeAll();
        for i in 0..<numsection{
            for j in 0..<itemNum{
                let layout = self.layoutAttributesForItem(at: IndexPath(item: j, section: i))!;
                self.layoutAttributes.append(layout);
            }
        }
        
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        assert((self.collectionView!.frame.width-self.contentInsets.left - self.contentInsets.right) >= (self.itemSize.width*CGFloat(self.numRow)), "布局宽度不能超过父试图宽度")
        
        assert((self.collectionView!.frame.height-self.contentInsets.top - self.contentInsets.bottom) >= self.itemSize.height*CGFloat(self.numCol), "布局高度不能超过父视图高度")
        
        let layoutAttribute = super.layoutAttributesForItem(at: indexPath);
        
        //计算水平距离
        let hor_spacing = (self.collectionView!.frame.width - CGFloat(self.numRow) * self.itemSize.width - self.contentInsets.left - self.contentInsets.right) / CGFloat(self.numRow - 1);
        
        //计算垂直距离
        let ver_spacing = (self.collectionView!.frame.height - CGFloat(self.numCol) * self.itemSize.height - self.contentInsets.top - self.contentInsets.bottom) / CGFloat(self.numCol - 1);
        
        //计算x的位置
        var frame_x = CGFloat(indexPath.section) * self.collectionView!.frame.width + CGFloat(indexPath.row%self.numRow) * self.itemSize.width + self.contentInsets.left;
        frame_x += (hor_spacing*(CGFloat(indexPath.row%self.numRow)));
        
        
        
        //计算y的位置
        var frame_y = CGFloat((indexPath.row/self.numRow)) * self.itemSize.height + self.contentInsets.top;
        
        frame_y += (ver_spacing*CGFloat(indexPath.row/self.numRow));
        
        layoutAttribute?.frame = CGRect(x:frame_x, y:frame_y, width: self.itemSize.width, height: self.itemSize.height);
        
        return layoutAttribute;

        
    }
    override open var collectionViewContentSize: CGSize {
        
        return CGSize(width: (self.collectionView?.frame.width)! * CGFloat(self.collectionView!.numberOfSections), height: self.collectionView!.frame.height);
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.layoutAttributes
    }
    

    
}
