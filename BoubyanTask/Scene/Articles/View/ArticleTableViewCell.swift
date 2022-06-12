//
//  ArticleTableViewCell.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 12/06/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var articleSubTitleLbl: UILabel!
    @IBOutlet weak var writenByLbl: UILabel!
    
    var article: ArticleModel? {
        didSet {
            articleTitleLbl.text = article?.title ?? "No Title"
            articleSubTitleLbl.text = article?.abstract ?? "No SubTitle"
            writenByLbl.text = article?.byline ?? "No Auther"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
