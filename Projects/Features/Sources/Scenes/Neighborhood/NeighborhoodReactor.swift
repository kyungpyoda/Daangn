//
//  NeighborhoodReactor.swift
//  Features
//
//  Created by 홍경표 on 2021/07/23.
//  Copyright © 2021 pio. All rights reserved.
//

import Foundation
import ReactorKit

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
        var posts: ([Post], [IndexPath]?) = ([], nil)
    }
    
    enum PostUpdate {
        case added
        case reset
    }
    
    // MARK: Properties
    
    var isInProgress: Bool = false
    
    let initialState: State
    
    // MARK: Initializers
    
    init() {
        initialState = State()
        action.onNext(.refresh)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let new = Post.pagination[initialState.page] ?? []
            return .just(.resetPosts(with: new))
        case .fetch:
            let fetched = Post.pagination[currentState.page] ?? []
            return .just(.addPosts(with: fetched))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .resetPosts(newPosts):
            newState.posts = (newPosts, nil)
            newState.page = newPosts.isEmpty ? newState.page : newState.page + 1
            
        case let .addPosts(addedPosts):
            let newIndices = diffIndices(beforeCount: newState.posts.0.count, newFetchedCount: addedPosts.count)
            newState.posts = (newState.posts.0 + addedPosts, newIndices)
            newState.page = addedPosts.isEmpty ? newState.page : newState.page + 1
        }
        
        return newState
    }
    
    private func diffIndices(beforeCount: Int, newFetchedCount: Int) -> [IndexPath] {
        return (beforeCount..<beforeCount+newFetchedCount).map { IndexPath(row: $0, section: 0) }
    }
    
}
