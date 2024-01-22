//
//  CameraCaptureViewController.swift
//  CustomImgCroper
//
//  Created by EOO61 on 06/11/23.
//

import UIKit
import MBDocCapture


class CameraCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func captureImage(_ sender: UIButton) {
        
        let scanner = ImageScannerController(delegate: self)
        scanner.shouldScanTwoFaces = false
        present(scanner, animated: true)
        /*
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    
        */
    }
    
    @IBAction func uploadImageFromGallert(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = false //true
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
           // selectedImage = image
           // imageView.image = image
           // performCropping()
            let scanner = ImageScannerController(image: image,delegate: self) //ImageScannerController(delegate: self)
            scanner.shouldScanTwoFaces = false
            present(scanner, animated: true)
        }
        
        
    }

}

extension CameraCaptureViewController: ImageScannerControllerDelegate {
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        scanner.dismiss(animated: true) {

            if results.doesUserPreferEnhancedImage {
                self.imageView.image          =   results.enhancedImage
            } else {
                self.imageView.image          =   results.scannedImage
            }
        }
    }
    
    func imageScannerController(_ scanner: MBDocCapture.ImageScannerController, didFinishScanningWithPage1Results page1Results: MBDocCapture.ImageScannerResults, andPage2Results page2Results: MBDocCapture.ImageScannerResults) {
        //optional - this is for 2 pages doc
    }

    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        scanner.dismiss(animated: true)
    }
}

