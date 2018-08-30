//
//  NewsCell.swift
//  SeedAppInterView
//
//  Created by chad chen on 2018-08-29.
//  Copyright © 2018 chad chen. All rights reserved.
//

import UIKit
import EasyPeasy

class NewsCell: UICollectionViewCell {
    //UI
    private var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 14)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.alpha = 0.8
        return label
    }()
    //Called in DataSourceDelegate to update Cell
    func update(_ data: NewsItem) {
        imageView.image = data.image
        titleLabel.text = data.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        //AddViews
        addSubview(imageView)
        addSubview(titleLabel)
        //AutoLayout
        imageView.easy.layout(Edges())
        titleLabel.easy.layout([
            Height(38),
            Left(),
            Right(),
            Bottom()
            ])
        //Corner Radio
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
