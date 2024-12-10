//
//  PostsForUsersHomeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/03/2023.
//

import Foundation
import Combine
import CoreLocation
class PostsForUsersHomeViewModel : ObservableObject {
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var filterModel = FilterModel()
    @Published var selectedIsParam = "Party"
    @Published var selectedTag = FiltersCases()
    @Published var postsForUsersModel : GetPostsForUsersHomeModel = GetPostsForUsersHomeModel()
    @Published var filteredEvents : [GetPostsForUsersHomeBody] = []
    @Published var filteredEventsTemp : [GetPostsForUsersHomeBody] = []
    @Published var tempEvents : [GetPostsForUsersHomeBody] = []
    private var  postsForUsersData : Cancellable?
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var eventLikeModel = EventLikeModel()
    @Published var getEventLikeModel = GetEventLikeModel()
    @Published var isFree = false
    @Published var priceRange = false
    @Published var peopleRange = false
    @Published var modeFilter = false
    @Published var locationFilter = false
    @Published var minFreePaid = ""
    @Published var maxFreePaid = ""
    @Published var peopleMin = ""
    @Published var peopleMax = ""
    @Published var mood = ""
    @Published var radiusKM = 0.0
    @Published var isPaid = false
    @Published var location = ""
    @Published var selectedStatus : partyStatus = .isParty
    @Published var selectedTime : partyStatus = .today
    @Published var liedIds : [String] = []
    private var  eventLikeData : Cancellable?
    @Published var allLikes: [String] = []
 
    init(){
        postsForUserHome()
    }
    func postsForUserHome(){
        showProgress = true
        let url = URL(string:  postsForUsersDev)!
        postsForUsersData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetPostsForUsersHomeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.postsForUsersModel = returnedProduct
                self?.allLikes = []
                if self?.postsForUsersModel.status ?? false {
                    _ = self?.postsForUsersModel.body.filter({$0.isLike == true}).map({ ptID in
                        self?.allLikes.append(ptID.id)
                    })
                    self?.showProgress = false
                    self?.filteredEvents = self?.postsForUsersModel.body ?? []
                    self?.selectedTag.isParty = true
                    self?.selectedTag.isToday = true
                    self?.filterData()
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                    self?.errorMessage = "Like does not exist."
                }

                print(self?.postsForUsersModel as Any)
                self?.postsForUsersData?.cancel()
            })
    }
   
    func filterData(){
        filteredEvents = postsForUsersModel.body
        print(filteredEvents)
        print(filteredEvents.count)
        
        if selectedStatus == .isBefore{
            filteredEvents = filteredEvents.filter({$0.isBefore == true})
        }
        else if selectedStatus == .isAfter {
            filteredEvents = filteredEvents.filter({$0.isAfter == true})
        }
        else if selectedStatus == .isParty {
            filteredEvents = filteredEvents.filter({$0.isParty == true})
        }
        if isFree {
            filteredEvents = filteredEvents.filter({$0.freePaid == true})
        }
        print(filteredEvents.count)
        timeFilter()
    }
    func timeFilter(){
        print(filteredEvents)
        print(filteredEvents.count)
        if selectedTime == .missed {
            filteredEvents = filteredEvents.filter({$0.endTime.toDate() < Date()})
        }
        else if selectedTime == .today {
            filteredEvents = filteredEvents.filter({$0.endTime.toDate1() == Date().toTodate() || $0.startTime.toDate1() == Date().toTodate()})
        }
        else if selectedTime == .upcomming {
            filteredEvents = filteredEvents.filter({$0.endTime.toDate() > Date()})
        }else{
            filteredEvents = []
        }
        filteredEventsTemp = filteredEvents
    }
    func likeUnLike(id: String){
        if liedIds.contains(where: {$0 == id}){
            liedIds.removeAll(where: {$0 == id})
        }else{
            liedIds.append(id)
        }
    }
    func advancedFilter(){
        filteredEvents = filteredEventsTemp
        if isFree{
            filteredEvents = filteredEvents.filter({$0.freePaid == true})
        }
        if priceRange{
            filteredEvents = filteredEvents.filter({$0.price >= minFreePaid &&  $0.price <= maxFreePaid})
        }
        if peopleRange{
            filteredEvents = filteredEvents.filter({$0.user.count >= Int(peopleMin) ?? 0 &&  $0.user.count <= Int(peopleMax) ?? 0})
        }
        if modeFilter{
//            filteredEvents = filteredEvents.filter({$0.user.count >= Int(peopleMin) ?? 0 &&  $0.user.count <= Int(peopleMax) ?? 0})
        }
        if locationFilter{
            fiterLocation(radius: Double(location) ?? 0.0)
        }
    }
    func removeAdvancedFilter(){
        filteredEvents = filteredEventsTemp
        minFreePaid = ""
        maxFreePaid = ""
        peopleMin = ""
        peopleMax  = ""
        mood = ""
        location = ""
        priceRange = false
        peopleRange = false
        modeFilter = false
        locationFilter = false
    }
    func advancedFilterCheck(){
        if minFreePaid != "" &&  maxFreePaid  != ""{
            priceRange = true
        }else{
            priceRange = false
        }
        if peopleMin != "" &&  peopleMax  != ""{
            peopleRange = true
        }else{
            peopleRange = false
        }
        if mood != ""{
            modeFilter = true
        }else{
            modeFilter = false
        }
        if location != ""{
            locationFilter = true
        }else{
            locationFilter = false
        }
        advancedFilter()
    }
    func eventLike(){
        let dictData = eventLikeModel.dict
        let blockUserURL  = URL(string: eventLikeURL)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        eventLikeData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetEventLikeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getEventLikeModel = returnedProduct
                if self?.getEventLikeModel.status ?? false {
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                }
                print(self?.getEventLikeModel as Any)
                self?.eventLikeData?.cancel()
                })
    }
    func fiterLocation(radius : Double){
        let locationsList = filteredEvents.map { loc in
            CLLocation(latitude: Double(loc.latitude) ?? 0.0, longitude: Double(loc.longitude) ?? 0.0)
        }
        let centerLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // center location
        let radiuss: CLLocationDistance = radius * 1000 // radius in meters
        let locations: [CLLocation] = locationsList // array of locations to filter

        filteredEvents = filteredEvents.filter { location in
            CLLocation(latitude: Double(location.latitude) ?? 0.0, longitude: Double(location.longitude) ?? 0.0).distance(from: centerLocation) <= radiuss
        }
        print(filteredEvents.count)
    }
    
    
    // test
    
    
    
    func checkSelectedValue(selected : partyStatus) -> String {
        switch selected {
        case .isBefore:
            return "Before"
        case .isParty:
            return "Party"
        case .isAfter:
            return "After Party"
        case .missed:
           return "Missed"
        case .today:
            return "Today"
        case .upcomming:
            return "Upcoming"
        }
    }
    func swapFunction(initialVallue: partyStatus, selectedValue: partyStatus) -> (swiped: partyStatus, selectedValue: partyStatus){
        return (selectedValue, initialVallue)
    }
    func swapFunctionTime(initialVallue: partyStatus, selectedValue: partyStatus) -> (swiped: partyStatus, selectedValue: partyStatus){
        filterData()
        return (selectedValue, initialVallue)
    }
    
}

enum partyStatus{
    case isBefore
    case isParty
    case isAfter
    case missed
    case today
    case upcomming
}
