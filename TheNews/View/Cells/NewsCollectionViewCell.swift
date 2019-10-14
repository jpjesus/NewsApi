//
//  NewsCollectionViewCell.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum NewsType {
    case headline
    case normal
}

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContainerView: UIView! {
        didSet {
            cellContainerView.setupShadow(radius: 5.0, opacity: 0.5, offset: 2.0, color: UIColor.cloudy())
            cellContainerView.setupRoundedCorners(radius: 10)
        }
    }
    @IBOutlet weak var articleImageView: UIImageView! {
        didSet {
            articleImageView.contentMode = .scaleAspectFit
            articleImageView.setupShadow(radius: 5.0, opacity: 0.5, offset: 2.0, color: UIColor.cloudy())
            articleImageView.setupRoundedCorners(radius: 10)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            titleLabel.textColor = UIColor.purpleBrown(1.0)
            titleLabel.lineBreakMode = .byTruncatingTail
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.font = UIFont.basicFont(size: 12)
            contentLabel.lineBreakMode = .byTruncatingTail
            contentLabel.textColor = UIColor.charcoal()
            contentLabel.adjustsFontSizeToFitWidth = false
            contentLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var souceLabel: UILabel! {
        didSet {
            souceLabel.textColor = UIColor.purpleBrown(0.9)
            souceLabel.font = UIFont.italicSystemFont(ofSize: 10)
        }
    }
    
    private let noContent: String = "No content provided"
    private let noAuthor: String = "No author provided"
    private let noAvailable: String = "Source: No available"
    
    func buildCell(with article: Article, type: NewsType) {
        titleLabel.text = article.title
        switch type {
        case .headline:
            contentLabel.text = !article.content.isEmpty ? article.content : noContent
        default:
            contentLabel.text = !article.articleDescription.isEmpty ? article.articleDescription : noContent
        }
        let source = article.source.name ?? ""
        souceLabel.text = !source.isEmpty ? source : noAvailable
        setImageUrl(article: article)
    }
    
    private func setImageUrl(article: Article) {
        let url = article.imageUrl
        articleImageView.kf.indicatorType = .activity
        articleImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
