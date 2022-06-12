//
//  ArticlesVC+TableViewEx.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 12/06/2022.
//

import UIKit

extension ArticlesVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.article = viewModel.getRowAtIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = viewModel.getRowAtIndex(indexPath.row) else {
            return
        }
        self.coordinator?.navigateArticleDetailsScreen(article: article)
    }
}
