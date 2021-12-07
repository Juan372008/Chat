//
//  PhotoCell.swift
//  Chat
//
//  Created by Juan Gallo on 27/5/21.
//

import UIKit

class PhotoCell: UITableViewCell {

    
    @IBOutlet weak var buttonIcon: UIButton!
    
    @IBOutlet weak var comment: UILabel!

    @IBOutlet weak var imagePrueba: UIImageView!
    
    var photo:PhotoTwo?
    
    var photoTwo:PhotoTwo?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayPhoto(photo:PhotoTwo){
        
        self.buttonIcon.imageView?.image = nil
        self.photo = photo
    
        if photo.url == nil {
            return
        }
        
        if let cachedImage = ImageCacheService.getImage(url: photo.url){

            self.buttonIcon.setImage(cachedImage, for: .normal)
            return
        }
//        else {
        
        let url = URL(string: (photo.url))
        
        if url == nil {
            return
        }
        
        
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url!) { data , response , error  in
                
//            }
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)

                
                if url?.absoluteString != self.photo?.url {
                    return
                }
                
                
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                DispatchQueue.main.async {
                    self.buttonIcon.setImage(image, for: .normal)
                   
                }
            }
        }
            
    
        dataTask.resume()
        }
    }
  


