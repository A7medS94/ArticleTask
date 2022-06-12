//
//  ArticleDetailsVC.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 12/06/2022.
//

import UIKit
import SDWebImage

class ArticleDetailsVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var articleSubTitleLbl: UILabel!
    @IBOutlet weak var byLbl: UILabel!
    
    //MARK: - Vars
    private var article: ArticleModel?
    weak var coordinator: MainCoordinator?
    
    
    //MARK: - ViewLifeCycle
    convenience init(article: ArticleModel) {
        self.init()
        self.article = article
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupImage()
        setupData()
    }
    
    //MARK: - Methods
    fileprivate func setupImage() {
        
        articleImageView.layer.cornerRadius = articleImageView.frame.height / 2
        articleImageView.clipsToBounds = true
        
        if let media = article?.media?.first,
           let meta = media.metaData?.first,
           let url = meta.url {
            articleImageView.sd_setImage(with: url)
        }else {
            articleImageView.backgroundColor = .systemGray6
        }
    }
    
    fileprivate func setupData() {
        articleTitleLbl.text = article?.title ?? "No Title"
        articleSubTitleLbl.text = article?.abstract ?? "No SubTitle"
        byLbl.text = article?.byline ?? "No Auther"
    }
}
