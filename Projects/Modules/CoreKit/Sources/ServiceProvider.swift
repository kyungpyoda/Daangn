//
//  ServiceProvider.swift
//  CoreKit
//
//  Created by 홍경표 on 2021/07/26.
//  Copyright © 2021 pio. All rights reserved.
//

import Foundation

public protocol ServiceProviderType: AnyObject {
    var neighborhoodService: NeighborhoodServiceType { get }
}

public final class ServiceProvider: ServiceProviderType {
    public static let shared: ServiceProviderType = ServiceProvider()
    private init() {}
    
    public lazy var neighborhoodService: NeighborhoodServiceType = NeighborhoodService(provider: self)
}
