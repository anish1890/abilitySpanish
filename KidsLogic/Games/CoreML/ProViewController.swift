//
//  ProViewController.swift
//  myCoreML
//
//  Created by macbookpro on 29/08/2018.
//  Copyright © 2018 Anish. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ProViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let goolenetModel = Inceptionv3()
    let imagePicker = UIImagePickerController()
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var confidenceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if let image = imageView.image {
            processImage(image: image)
        }
    }
    
    func processImage(image:UIImage) {
        
        if let model = try? VNCoreMLModel(for : self.goolenetModel.model) {
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let result = request.results as? [VNClassificationObservation] {
                    
                    for classification in result {
                        
                        print("ID \(classification.identifier) confidence : \(classification.confidence)")
                    }
                    
                    self.descriptionLabel.text = result.first?.identifier
                    
                    if let myConfidence =   result.first?.confidence {
                        self.confidenceLabel.text = "\(myConfidence * 100.0)%"
                    }
                }
                
            }
            
            if let imageData = image.pngData(){
                
                let handler =  VNImageRequestHandler(data: imageData, options: [:])
                
                try?handler.perform([request])
                
            }
            
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            processImage(image: selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismiss(animated: true, completion: nil)
        
        //save to album
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        
    }
            
            
    @IBAction func camera(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func gallery(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        
    }
    @IBAction func closeThis(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
