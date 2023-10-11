//
//  ReposListViewModel.swift
//  PomacTask
//
//  Created by ahlam on 10/10/2023.
//

import Foundation
import Alamofire



protocol ReposListViewModelProtocol {
    
    var result:Observable<[RepoModel]?> { get set }
    var errorMessage:Observable<String?> { get set }
    var isLoading:Observable<Bool?>{get set}
    var dateDiff:Observable<String?>{get set}
    var convertedDate : Observable<String?>{get set}
    func getRepos()
    func checkCreatedAt(date : String)
}

class ReposListViewModel  : ReposListViewModelProtocol {
    

    var result: Observable<[RepoModel]?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    var isLoading: Observable<Bool?> = Observable(false)
    var dateDiff: Observable<String?> = Observable(nil)
    var convertedDate : Observable<String?> =  Observable(nil)

    func getRepos() {
        self.isLoading.value = true
        
     AF.request(baseAPIURL + reposPath).responseDecodable(of: [RepoModel].self) { [self] response in
         
        self.isLoading.value = false
         print("repos respo",response)
        switch response.result {
            
        case .success(let result):
            self.result.value = result
        case .failure(let error):
            self.errorMessage.value = error.localizedDescription
        }
    }
        
        
    }
 
    //for get the different between current date and created at date
    func checkCreatedAt(date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let currentDate = Date()
    

        if let specificDate = dateFormatter.date(from: date) {
            var calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: specificDate, to: currentDate)
            
        
            
            if let month = components.month, let year = components.year {
                if month <= 6 && year <= 0 {
                    if month > 0 {
                        dateDiff.value = "\(month) months ago"
                    } else if let day = components.day, day > 0 {
                        dateDiff.value = "\(day) days ago"
                    } else if let hour = components.hour, hour > 0 {
                        dateDiff.value = "\(hour) hours ago"
                    } else if let minute = components.minute, minute > 0 {
                        dateDiff.value = "\(minute) minutes ago"
                    } else if let second = components.second, second > 0 {
                        dateDiff.value = "\(second) seconds ago"
                    } else {
                        dateDiff.value = "Just now"
                    }
                }
            }
        } else {
            print("Invalid date format")
        }
    }
    
    
    //covert the date format in case more than 6 moths
    func convertDateFormat(date : String){

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = inputFormatter.date(from: date)

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let formattedDate = outputFormatter.string(from: date!)
        convertedDate.value = formattedDate
    }
    
    
    

}
