//
//  GCLocationManagerDelegate.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/11/22.
//

import Foundation

/// Abstract protocols to be used as part of the business logic.
protocol GCLocationManagerDelegate: AnyObject {
    func gclocationManager(_ manager: GCLocationManagerProtocol, isPermissionGranted: Bool)
    func gclocationManager(_ manager: GCLocationManagerProtocol, didReceiveLocationData data: LocationData)
}
