//
//  CarouselViewCell.swift
//  ilaBankTest
//
//  Created by Rohan Panchal on 16/08/24.
//

import UIKit

// MARK: - CarouselViewCellDelegate
protocol CarouselViewCellDelegate: AnyObject {
    func carouselImageScrolled(atIndex: Int)
    func carouselPageIndicatorChanged(atIndex: Int)
}

class CarouselViewCell: UITableViewCell {
    @IBOutlet weak var carouselView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    var carouselViewCellDelegate: CarouselViewCellDelegate?

    var listData: [ListModel]? {
        didSet {
            pageControl.numberOfPages = listData!.count
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.register(UINib.init(nibName: "CarouselImageCell", bundle: nil), forCellWithReuseIdentifier: "carouselImageCell")
        
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UICollectionViewDataSource
extension CarouselViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselImageCell", for: indexPath) as! CarouselImageCell
        
        cell.carouselImageView.image = UIImage(named: listData?[indexPath.item].carouselImage ?? "")
        cell.carouselImageView.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.carouselView.frame.size.width - 30, height: self.carouselView.frame.size.height - 15)  // Set custom size for cells
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(page)
        carouselViewCellDelegate?.carouselImageScrolled(atIndex: Int(page))
    }
}

// MARK: - UIPageControl Action
extension CarouselViewCell {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = sender.currentPage        
        carouselView.scrollToItem(at: IndexPath(indexes: [0,currentPage]), at: .centeredHorizontally, animated: true)
        carouselViewCellDelegate?.carouselPageIndicatorChanged(atIndex: currentPage)
    }
}
