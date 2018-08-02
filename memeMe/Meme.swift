//
//  Meme.swift
//  memeMe
//
//  Created by Andres Yepes on 7/31/18.
//  Copyright © 2018 Andres Yepes. All rights reserved.
//

import UIKit

struct Meme{
    let topText: String
    let bottomText: String
    let image: UIImage
    let memeImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
}
