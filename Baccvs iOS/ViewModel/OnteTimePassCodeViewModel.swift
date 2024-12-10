//
//  OnteTimePassCodeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 11/03/2023.
//

import Foundation
import SwiftUI
import Combine
class OTPCodeViewModel: ObservableObject {
    @Published var otptext:String=""
    @Published var otpfields:[String]=Array(repeating: "", count: 6)
}
