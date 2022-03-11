//
//  GCLocationManagerDelegate.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/11/22.
//

import Foundation

protocol GCLocationManagerDelegate: AnyObject {
    func gclocationManager(_ manager: GCLocationManagerProtocol, isPermissionGranted: Bool)
    func gclocationManager(_ manager: GCLocationManagerProtocol, didReceiveLocationData data: LocationData)
}
