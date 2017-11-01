//
//  ViewController.swift
//  SwiftTextRecognition
//
//  Created by Shinichi Akimoto on 2017/11/1.
//  Copyright © 2017年 Shnichi Akimoto. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,G8TesseractDelegate {

    
    @IBOutlet var textView: UITextView!
    
    var recogImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    @IBAction func camera(_ sender: Any) {
    
    
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }

    @IBAction func album(_ sender: Any) {
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            recogImage = pickedImage
            
  
        }
        
        //カメラ画面(アルバム画面)を閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func startRecognition(_ sender: Any) {
        
        if let tesseract = G8Tesseract(language: "jpn"){
        
            tesseract.delegate = self
            tesseract.image = recogImage.g8_blackAndWhite()
            tesseract.pageSegmentationMode = G8PageSegmentationMode.auto
            tesseract.recognize()
            textView.text = tesseract.recognizedText
        }

    }
    
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        
        print("進行中 \(tesseract.progress) %")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    
    }


}

