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
    var monthsDiff:Observable<Int?>{get set}
    var convertedDate : Observable<String?>{get set}
    func getRepos()
    func checkCreatedAt(date : String)
}

class ReposListViewModel  : ReposListViewModelProtocol {
    

    var result: Observable<[RepoModel]?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    var isLoading: Observable<Bool?> = Observable(false)
    var monthsDiff: Observable<Int?> = Observable(nil)
    var convertedDate : Observable<String?> =  Observable(nil)

    func getRepos() {
        self.isLoading.value = true
        
     AF.request("https://api.github.com/repositories").responseDecodable(of: [RepoModel].self) { [self] response in
         
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
    func checkCreatedAt(date : String ) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let specificDate = dateFormatter.date(from: date)  {
          
            let calendar = Calendar.current

            let currentDate = Date()
            let components = calendar.dateComponents([.month], from: specificDate, to: currentDate)
            let diffInMonths = components.month ?? 0

            self.monthsDiff.value = diffInMonths
           
            print("The difference in months is: \(diffInMonths)")
        }

        else  {
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
