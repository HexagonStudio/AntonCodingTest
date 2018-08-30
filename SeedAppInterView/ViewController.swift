//
//  ViewController.swift
//  SeedAppInterView
//
//  Created by chad chen on 2018-08-29.
//  Copyright © 2018 chad chen. All rights reserved.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController {
    //UI
    var collectionView: UICollectionView!
    //CollectionViewDataSource
    var news: [NewsItem] {
        get {
            return NewsItem.fetchNews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCollectionView()
    }

    func layoutCollectionView() {
        let layout = CustomLayout()
        layout.delegate = self
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        //AutoLayout
        collectionView.easy.layout(Edges())
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
        cell.update(news[indexPath.row])
        return cell
    }
}

extension ViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, imageHeightAtIndex index: IndexPath) -> CGFloat {
        //use ratio to prevent cell too long
        let ratio = news[index.row].image.size.height / news[index.row].image.size.width
        //height for cell
        let height = ratio * (view.frame.width * 0.5 - (CustomLayout.cellPadding * 2))
        //38 is the label Height, if smaller just return 38
        return height >= 38 ? height : 38
    }
}
