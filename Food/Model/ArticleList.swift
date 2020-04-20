//
//  MenuList.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 13.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?

}
