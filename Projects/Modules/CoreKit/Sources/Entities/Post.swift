//
//  Post.swift
//  CoreKit
//
//  Created by 홍경표 on 2021/07/26.
//  Copyright © 2021 pio. All rights reserved.
//

import Foundation

// Todo: Category 구분,,

public struct Post {
    public var contents: String
    public var imageURLStr: String?
    public var writer: User
    public var postDate: Date
    public var reaction: [Reaction]
    public var comments: [String]
}
extension Post {
    static let pagination: [Int: [Post]] = [
        1: (0..<10).map { i in .init(contents: String(repeating: "안녕하세요 홍경표입니다. 호호 ㅁㄴㅇㄹ ", count: Int.random(in: 1...4)),
                                     imageURLStr: (Bool.random() ? "cloud.rain" : nil),
                                     writer: .dummy.randomElement()!,
                                     postDate: Calendar.current.date(byAdding: .hour, value: -i, to: Date())!,
                                     reaction: Reaction.dummy,
                                     comments: (0..<Int.random(in: 1...4)).map { "\($0)" }) },
        2: (0..<10).map { i in .init(contents: String(repeating: "안녕하세요 홍경표입니다. 호호 ㅁㄴㅇㄹ ", count: Int.random(in: 1...4)),
                                     imageURLStr: (Bool.random() ? "cloud.rain" : nil),
                                     writer: .dummy.randomElement()!,
                                     postDate: Calendar.current.date(byAdding: .hour, value: -(i+10), to: Date())!,
                                     reaction: Reaction.dummy,
                                     comments: (0..<Int.random(in: 1...4)).map { "\($0)" }) },
        3: (0..<10).map { i in .init(contents: String(repeating: "안녕하세요 홍경표입니다. 호호 ㅁㄴㅇㄹ ", count: Int.random(in: 1...4)),
                                     imageURLStr: (Bool.random() ? "cloud.rain" : nil),
                                     writer: .dummy.randomElement()!,
                                     postDate: Calendar.current.date(byAdding: .hour, value: -(i+20), to: Date())!,
                                     reaction: Reaction.dummy,
                                     comments: (0..<Int.random(in: 1...4)).map { "\($0)" }) },
    ]
    static let maxPage: Int = 3
}

public enum Reaction {
    case thumbsUp
    case heart
    case smile
}
extension Reaction: CaseIterable {
    static var dummy: [Reaction] {
        return (0..<Int.random(in: 1...4)).compactMap { _ in Reaction.allCases.randomElement() }
    }
}

public struct User {
    public var nickname: String
    public var location: String
}
extension User {
    static let dummy: [User] = [
        .init(nickname: "홍경표", location: "강서구 마곡동"),
        .init(nickname: "홍홍", location: "강서구 등촌동"),
        .init(nickname: "당근", location: "강서구 강서동"),
        .init(nickname: "토끼", location: "강서구 동동동"),
        .init(nickname: "토당", location: "강서구 홍홍동"),
    ]
}
