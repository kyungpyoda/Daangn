//
//  NeighborhoodReactor.swift
//  Features
//
//  Created by 홍경표 on 2021/07/23.
//  Copyright © 2021 pio. All rights reserved.
//

import Foundation
import ReactorKit
import CoreKit

final class NeighborhoodReactor: Reactor {
    
    enum Action {
        case refresh
        case fetch
    }
    
    enum Mutation {
        case resetPosts(with: [Post])
        case addPosts(with: [Post])
    }
    
    struct State {
        var page: Int = 1
        var posts: (data: [Post], newIndices: [IndexPath]?) = ([], nil)
    }
    
    enum PostUpdate {
        case added
        case reset
    }
    
    // MARK: Properties
    
    let initialState: State
    let provider: ServiceProviderType
    let errorSubject: PublishSubject<Error> = .init()
    
    // MARK: Initializers
    
    init(provider: ServiceProviderType) {
        initialState = State()
        self.provider = provider
        
        action.onNext(.refresh)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let pageToFetch = initialState.page
            return provider.neighborhoodService.fetchPosts(for: pageToFetch)
                .catchError { [weak self] error in
                    self?.errorSubject.onNext(error)
                    return .empty()
                }
                .flatMap { posts -> Observable<Mutation> in
                    return .just(.resetPosts(with: posts))
                }
            
        case .fetch:
            let pageToFetch = currentState.page
            return provider.neighborhoodService.fetchPosts(for: pageToFetch)
                .catchError { [weak self] error in
                    self?.errorSubject.onNext(error)
                    return .empty()
                }
                .flatMap { posts -> Observable<Mutation> in
                    return .just(.addPosts(with: posts))
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .resetPosts(newPosts):
            newState.posts = (newPosts, nil)
            newState.page = newPosts.isEmpty ? newState.page : newState.page + 1
            
        case let .addPosts(addedPosts):
            let newIndices = diffIndices(beforeCount: newState.posts.data.count, newFetchedCount: addedPosts.count)
            newState.posts = (newState.posts.data + addedPosts, newIndices)
            newState.page = addedPosts.isEmpty ? newState.page : newState.page + 1
        }
        
        return newState
    }
    
    private func diffIndices(beforeCount: Int, newFetchedCount: Int) -> [IndexPath] {
        return (beforeCount..<beforeCount+newFetchedCount).map { IndexPath(row: $0, section: 0) }
    }
    
}
