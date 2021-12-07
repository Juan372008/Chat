//
//  CameraService.swift
//  Chat
//
//  Created by Juan Gallo on 14/5/21.
//

import Foundation
import UIKit

class  CameraService {
    func savePhoto(image:UIImage) {
        PhotoService.savePhoto(image: image)
    }
}
