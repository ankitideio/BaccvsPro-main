//
//  Extensions.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//

import Foundation
import Foundation
import UIKit
import SwiftUI
import Firebase
import RevenueCat
import OneSignal
extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
extension Encodable {
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
extension Date
{
    func toString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self)
    }

}
extension Date
{
    func toTodate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }

}
//extension String {
//   func toTodate() -> String {
//        let dateformat = DateFormatter()
//        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//        let todayDate = dateformat.date(from: self) ?? Date()
//        dateformat.dateFormat = "yyyy-MM-dd"
//        return dateformat.string(from: todayDate)
//    }
//}


extension String {
   func toDate() -> Date {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateformat.date(from: self) ?? Date()
    }
}
extension String {
   func toDay() -> Date {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.date(from: self) ?? Date()
    }
}
enum MyAlerts {
    case  success
    case  error
}

func getAlert(alertType: MyAlerts?, message: String) -> Alert {
    
    switch alertType {
    case .error:
        return Alert(title: Text(message))
    case .success:
        return Alert(title: Text(message),message: Text(message),dismissButton: .default(Text("OK"),action: {
           print("done")
        }))
    default:
       return Alert(title: Text("ERROR"))
    }
    
}

func resetDefaults() {
    // Removing External User Id with Callback Available in SDK Version 2.13.1+
    OneSignal.removeExternalUserId({ results in
        // The results will contain push and email success statuses
        print("External user id update complete with results: ", results!.description)
        // Push can be expected in almost every situation with a success status, but
        // as a pre-caution its good to verify it exists
        if let pushResults = results!["push"] {
            print("Remove external user id push status: ", pushResults)
        }
        // Verify the email is set or check that the results have an email success status
        if let emailResults = results!["email"] {
            print("Remove external user id email status: ", emailResults)
        }
    })
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}
extension Encodable {
    var dictionary: [String: Any]? {
       return try? Firestore.Encoder().encode(self)
    }
}
extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "days"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour" :
                "\(hour)" + " " + "hours"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute" :
                "\(minute)" + " " + "minutes"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second" :
                "\(second)" + " " + "seconds"
        } else {
            return "a moment ago"
        }
        
    }
}
extension Package {
    func terms(for package: Package) -> String {
        if let intro = package.storeProduct.introductoryDiscount {
            if intro.price == 0 {
                return "\(intro.subscriptionPeriod.periodTitle) free trial"
            } else {
                return "\(package.localizedIntroductoryPriceString!) for \(intro.subscriptionPeriod.periodTitle)"
            }
        } else {
            return "Unlocks Premium"
        }
    }
}

extension SubscriptionPeriod {
    var durationTitle: String {
        switch self.unit {
        case .day: return "day"
        case .week: return "week"
        case .month: return "month"
        case .year: return "year"
        @unknown default: return "Unknown"
        }
    }
    
    var periodTitle: String {
        let periodString = "\(self.value) \(self.durationTitle)"
        let pluralized = self.value > 1 ?  periodString + "s" : periodString
        return pluralized
    }
}
struct LightStatusBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIApplication.shared.statusBarStyle = .lightContent
            }
            .onDisappear {
                UIApplication.shared.statusBarStyle = .lightContent
            }
    }
}
extension View {
    func enableLightStatusBar() -> some View {
        self.modifier(LightStatusBarModifier())
    }
}
extension String {
   func toTodate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let todayDate = dateformat.date(from: self) ?? Date()
        dateformat.dateFormat = "'Date:' dd-MM-yyyy     'Time:' hh:mm a "
        dateformat.amSymbol = "AM"
        dateformat.pmSymbol = "PM"
        return dateformat.string(from: todayDate)
    }
    func toDate1() -> String {
         let dateformat = DateFormatter()
         dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         let todayDate = dateformat.date(from: self) ?? Date()
         dateformat.dateFormat = "yyyy-MM-dd"
         return dateformat.string(from: todayDate)
     }
}
extension String {
   func toTodatedob() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let todayDate = dateformat.date(from: self) ?? Date()
        dateformat.dateFormat = "dd MMMM yyyy"
        return dateformat.string(from: todayDate)
    }
}


extension Date {
    static func convertToCustomFormat(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        if let date = dateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "EEE dd MMM 'from' h:mm a 'to' h:mm a"
            return outputDateFormatter.string(from: date)
        } else {
            return "Invalid date format"
        }
    }
}


extension Date {
    func ageString() -> String {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        
        if let age = ageComponents.year {
            return "\(age) years old"
        } else {
            return ""
        }
    }
}

extension String {
    func ageString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dateOfBirth = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: dateOfBirth, to: Date())
            
            if let years = dateComponents.year, let months = dateComponents.month, let days = dateComponents.day {
                return "\(years) years, \(months) months, \(days) days"
            }
        }
        
        return nil
    }
}


extension String {
    func age() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        if let dateOfBirth = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
            
            if let years = ageComponents.year {
                return years
            }
        }
        
        return nil
    }
}


extension String {
    func convertToCustomFormatDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}


extension String {
    func convertToCustomFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM yyyy, hh:mm a"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

//extension Date {
//    func isPast() -> Bool {
//        return self < Date()
//    }
//}
//extension String {
//    func toDate() -> Date? {
//        let dateFormatter = ISO8601DateFormatter()
//        return dateFormatter.date(from: self)
//    }
//}
