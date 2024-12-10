//
//  NetworkLayer.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestoreSwift
import Firebase
class NetworkLayer{
    static let database = Firestore.firestore()
    enum NetworkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String?{
            switch self{
            case .badURLResponse(url: let url) : return "[❌] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    static func download(url: URL, req: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: req)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 600 else {
            
            throw NetworkingError.badURLResponse(url: url)
        }
        print(url)
        print("Response: \(response.statusCode)")
        return output.data
    }
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error)
            print(error.localizedDescription)
        }
    }
    static func requestType(apiTypes: apiTypes, contentType: String, url: URL, dataThing: Data?, boundary: String?) -> URLRequest{
        @AppStorage ("deviceToken") var deviceToken: String?
        var request = URLRequest(url: url)
        request.httpMethod = contentType
        request.setValue("Bearer \(deviceToken ?? "")",forHTTPHeaderField: "Authorization")
        if apiTypes == .jason {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }else if apiTypes == .formData{
            request.addValue("multipart/form-data; boundary=\(boundary ?? "")", forHTTPHeaderField: "Content-Type")
        }else if apiTypes == .xFormData{
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        if dataThing != nil{
            request.httpBody = dataThing!
        }
        return request
    }
    static func createPostFormData(dic: [String: Any], videos: Media, boundary: String) -> Data{
            var reuestData = Data()
            let lineBreak = "\r\n"
            dic.forEach { d in
                if d.key == "video"{
                    reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    reuestData.append("Content-Disposition: form-data; name=\"\(videos.paramName)\"; filename=\"\(videos.fileName)\"\r\n".data(using: .utf8)!)
                    reuestData.append("Content-Type: \(videos.mimeType)\r\n\r\n".data(using: .utf8)!)
                    reuestData.append(videos.part_vedio_url)
                    reuestData.append("\r\n".data(using: .utf8)!)
                }else{
                    reuestData.append("--\(boundary)\(lineBreak)" .data(using: .utf8)!)
                    reuestData.append("Content-Disposition: form-data; name=\"\(d.key)\" \(lineBreak + lineBreak)" . data(using: .utf8)!)
                    reuestData.append("\(d.value)\(lineBreak)" .data(using: .utf8)!)
                }
            }
            reuestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
            return reuestData
        }
    static func createFormData(dic: [String: Any], videos: [Media], thumbNial: Media, boundary: String) -> Data{
            var reuestData = Data()
            let lineBreak = "\r\n"
            dic.forEach { d in
                if d.key == "part_vedio_url"{
                    videos.forEach { dic in
                        reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
                        reuestData.append("Content-Disposition: form-data; name=\"\(dic.paramName)\"; filename=\"\(dic.fileName)\"\r\n".data(using: .utf8)!)
                        reuestData.append("Content-Type: \(dic.mimeType)\r\n\r\n".data(using: .utf8)!)
                        reuestData.append(dic.part_vedio_url)
                        reuestData.append("\r\n".data(using: .utf8)!)
                    }
                }else if d.key == "thum_nail"{
                    reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    reuestData.append("Content-Disposition: form-data; name=\"\(thumbNial.paramName)\"; filename=\"\(thumbNial.fileName)\"\r\n".data(using: .utf8)!)
                    reuestData.append("Content-Type: \(thumbNial.mimeType)\r\n\r\n".data(using: .utf8)!)
                    reuestData.append(thumbNial.part_vedio_url)
                    reuestData.append("\r\n".data(using: .utf8)!)
                }
                else{
                    reuestData.append("--\(boundary)\(lineBreak)" .data(using: .utf8)!)
                    reuestData.append("Content-Disposition: form-data; name=\"\(d.key)\" \(lineBreak + lineBreak)" . data(using: .utf8)!)
                    reuestData.append("\(d.value)\(lineBreak)" .data(using: .utf8)!)
                }
            }
            reuestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
            return reuestData
        }

    static func putProfileImage(dic: Media, boundary: String) -> Data{
            var reuestData = Data()
            let lineBreak = "\r\n"
            reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
            reuestData.append("Content-Disposition: form-data; name=\"\(dic.paramName)\"; filename=\"\(dic.fileName)\"\r\n".data(using: .utf8)!)
            reuestData.append("Content-Type: \(dic.mimeType)\r\n\r\n".data(using: .utf8)!)
            reuestData.append(dic.part_vedio_url)
            reuestData.append("\r\n".data(using: .utf8)!)
            reuestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
            
            return reuestData
        }
    static func createStoryFormData(img: [Media], boundary: String) -> Data{
        var reuestData = Data()
        let lineBreak = "\r\n"
        img.forEach { d in
            reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
            reuestData.append("Content-Disposition: form-data; name=\"\(d.paramName)\"; filename=\"\(d.fileName)\"\r\n".data(using: .utf8)!)
            reuestData.append("Content-Type: \(d.mimeType)\r\n\r\n".data(using: .utf8)!)
            reuestData.append(d.part_vedio_url)
            reuestData.append("\r\n".data(using: .utf8)!)
        }
        reuestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        return reuestData
    }
    // Update Event ThumbNil
    static func putThumbNilImage(dic: Media, boundary: String) -> Data{
            var reuestData = Data()
            let lineBreak = "\r\n"
            reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
            reuestData.append("Content-Disposition: form-data; name=\"\(dic.paramName)\"; filename=\"\(dic.fileName)\"\r\n".data(using: .utf8)!)
            reuestData.append("Content-Type: \(dic.mimeType)\r\n\r\n".data(using: .utf8)!)
            reuestData.append(dic.part_vedio_url)
            reuestData.append("\r\n".data(using: .utf8)!)
//            reuestData.append("--\(boundary)\(lineBreak)" .data(using: .utf8)!)
//            reuestData.append("Content-Disposition: form-data; name=\"event_id\" \(lineBreak + lineBreak)" . data(using: .utf8)!)
//            reuestData.append("\(eventId)\(lineBreak)" .data(using: .utf8)!)
        
            reuestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
            
            return reuestData
        }
    // Update Event Videos
    static func addVideoEventFormData(img: [Media], boundary: String) -> Data{
        var reuestData = Data()
        let lineBreak = "\r\n"
        img.forEach { d in
            reuestData.append("--\(boundary)\r\n".data(using: .utf8)!)
            reuestData.append("Content-Disposition: form-data; name=\"\(d.paramName)\"; filename=\"\(d.fileName)\"\r\n".data(using: .utf8)!)
            reuestData.append("Content-Type: \(d.mimeType)\r\n\r\n".data(using: .utf8)!)
            reuestData.append(d.part_vedio_url)
            reuestData.append("\r\n".data(using: .utf8)!)
        }
//        reuestData.append("--\(boundary)\(lineBreak)" .data(using: .utf8)!)
//        reuestData.append("Content-Disposition: form-data; name=\"event_id\" \(lineBreak + lineBreak)" . data(using: .utf8)!)
//        reuestData.append("\(eventId)\(lineBreak)" .data(using: .utf8)!)
        reuestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        return reuestData
    }
    static func addDataToFirebase(userId: String, reciverId: String,path: String, value: [String: Any], completion: @escaping(Bool) -> Void){
        database.collection("Baccvs").document(userId).collection("sendTo").document(reciverId).collection("message").addDocument(data: value) { error in
            if error == nil{
                completion(true)
                print("Working")
            }else{
                print("not working")
                completion(false)
            }
        }
    }
    static func addDataToConversation(userId: String, senderId: String,path: String, value: [String: Any], completion: @escaping(Bool) -> Void){
        database.collection("Baccvs").document(path).collection(userId).document(senderId).setData(value, merge: true){ error in
            if error == nil{
                completion(true)
                print("Working")
            }else{
                print("not working")
                completion(false)
            }
        }
    }
    static func getData(userId: String,path: String, completion: @escaping(QuerySnapshot?)-> Void){
        database.collection("Baccvs").document(path).collection(userId).addSnapshotListener { snapshot ,error in
            if error == nil{
                print("Working")
                completion(snapshot)
            }else{
                print("not working")
                print(snapshot as Any)
                
            }
        }
    }
    static func getChatData(userId: String,reciverId: String,path: String, completion: @escaping(QuerySnapshot?)-> Void){
        database.collection("Baccvs").document(userId).collection("sendTo").document(reciverId).collection("message").addSnapshotListener { snapshot ,error in
            if error == nil{
                print("Working")
                completion(snapshot)
            }else{
                print("not working")
                print(snapshot as Any)
                
            }
        }
    }
    static func addDataToGroupChat(userId: String, groupID: String, value: [String: Any], completion: @escaping(Bool) -> Void){
        database.collection("Baccvs").document("GroupChat").collection(groupID).addDocument(data: value){ error in
            if error == nil{
                completion(true)
                print("Working")
            }else{
                print("not working")
                completion(false)
            }
        }
    }
    static func getGroupChatData(groupID: String, completion: @escaping(QuerySnapshot?)-> Void){
        database.collection("Baccvs").document("GroupChat").collection(groupID).addSnapshotListener { snapshot ,error in
            if error == nil{
                print("Working")
                completion(snapshot)
            }else{
                print("not working")
                print(snapshot as Any)
                
            }
        }
    }

}
enum apiTypes{
    case jason
    case formData
    case xFormData
}

