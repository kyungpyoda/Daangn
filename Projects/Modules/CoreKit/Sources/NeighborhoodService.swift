//
//  NeighborhoodService.swift
//  CoreKit
//
//  Created by 홍경표 on 2021/07/26.
//  Copyright © 2021 pio. All rights reserved.
//

import Foundation
import RxSwift

public protocol NeighborhoodServiceType {
    func fetchPosts(for page: Int) -> Observable<[Post]>
}

public final class NeighborhoodService: NeighborhoodServiceType {
    
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    public func fetchPosts(for page: Int) -> Observable<[Post]> {
        return Observable<[Post]>.create { emitter in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if let fetched = Post.pagination[page] {
                    emitter.onNext(fetched)
                    emitter.onCompleted()
                } else {
                    emitter.onError(NeighborhoodServiceError.NoMoreData)
                }
            }
            return Disposables.create()
        }
    }
    
}

enum NeighborhoodServiceError: Error {
    case NoMoreData
}
