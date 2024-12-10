//
//  NetworkMonitorViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 22/03/2023.
//

import Network
import SwiftUI
import Combine
class NetworkMonitor : ObservableObject{
    let shared = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    @Published var isConnected = true
    let monitor = NWPathMonitor()
    init(){
        startMonitoring()
    }
    func startMonitoring() {
        monitor.pathUpdateHandler = {path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                print(path.status)
            }
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
