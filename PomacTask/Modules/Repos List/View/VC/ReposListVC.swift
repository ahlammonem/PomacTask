//
//  ViewController.swift
//  PomacTask
//
//  Created by ahlam on 09/10/2023.
//

import UIKit
import Kingfisher

class ReposListVC: UIViewController {

    //MARK: - OUTLETES
    @IBOutlet var reposTablViewOutlete: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    //MARK: - Vars
   var viewModel : ReposListViewModel!
   var reposList : [RepoModel] = []
   var createdat = ""
   var createdAtDate = "2007-08-20T05:24:19Z"
    
    //MARK: - Pagination vars
    var reposPerPages = 10
    var limit = 10
    var paginationReposList : [RepoModel] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ReposListViewModel()
        setUpTableView()
        viewModel.getRepos()
        viewModel.checkCreatedAt(date: createdAtDate)
        bindData()
    }
    
    
    
   
    
   
    func bindData(){
        
        //Get reposities list
        viewModel.result.bind { repos in
            guard let repos = repos else {return}
            self.reposList = repos
            self.limit = repos.count
            for i in 0..<10 {
                self.paginationReposList.append(repos[i])
            }
            self.reposTablViewOutlete.reloadData()

        }
        
        //Get isloading value
        viewModel.isLoading.bind { isLoading in
            guard let isLoading = isLoading else {return}
            if isLoading {
                self.loader.startAnimating()
            }
            else {
                self.loader.stopAnimating()
            }
        }
        
        //Get Error
        viewModel.errorMessage.bind { error in
            guard let error = error else {return}
            print(error)
        }
        
        viewModel.monthsDiff.bind { [self] months in
            guard let months = months else {return}
            if months < 6 {
                self.createdat =  "\(months) Months ago "
            }
            else {
                viewModel.convertDateFormat(date: self.createdAtDate)
                viewModel.convertedDate.bind { date in
                    guard let date = date else {return}
                    self.createdat =  date
                }
            }
        }
        
    }
    
    func setPaginationRepos(reposPerPage : Int){
        if reposPerPages >= limit {
            return
        }
        else if reposPerPages > limit - 10 {
            for i in reposPerPages..<limit {
                paginationReposList.append(reposList[i])
            }
            self.reposPerPages += 10
        }
        else {
            for i in reposPerPages..<reposPerPages + 10 {
                paginationReposList.append(reposList[i])
            }
            self.reposPerPages += 10
            
            }
        
        self.reposTablViewOutlete.reloadData()
       
    }
}




//Extension for setup tableview
extension ReposListVC :UITableViewDelegate , UITableViewDataSource  {
    
    func setUpTableView(){
        reposTablViewOutlete.delegate = self
        reposTablViewOutlete.dataSource = self
        reposTablViewOutlete.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paginationReposList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as! RepoCell
      
        let currentCell = paginationReposList[indexPath.row]
        cell.repoNameLbl.text = currentCell.name
        cell.ownerNameLbl.text = currentCell.owner?.login
        cell.createdAtLbl.text = createdat
        if let imageUrl = URL(string: (currentCell.owner?.avatar_url)!) {
            cell.repoImageView.kf.setImage(with: imageUrl)
        }
        
        else {
            print("image Url is not correct")
           
        }
   
        
                                 
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height/2
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == reposTablViewOutlete {
            if (scrollView.contentOffset.y + scrollView.frame.height) >= (scrollView.contentSize.height) {
                setPaginationRepos(reposPerPage: reposPerPages)
            }
        }
    }
    
    
}

