//
//  Meme.swift
//  memeMe
//
//  Created by Andres Yepes on 7/31/18.
//  Copyright © 2018 Andres Yepes. All rights reserved.
//

import UIKit

class Meme: NSObject {
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
    
    override var description: String {
        get {
            return """
            Meme
            topText: \(self.topText)
            bottomText: \(self.bottomText)
            image: \(self.image)
            memeImage: \(self.memeImage)
            """
        }
    }
}
