//
//  ViewController.swift
//  Camera
//
//  Created by Thales Toniolo on 10/18/14.
//  Copyright (c) 2014 FIAP. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	//MARK: - Interfaee declarations
	@IBOutlet weak var selectedImageView: UIImageView!

	//MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	//MARK: - Actions Methods
	@IBAction func takePictureTap(sender: UIButton) {
		// Valida se o dispositivo possui camera
		if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
			let imagePickerController:UIImagePickerController = UIImagePickerController()
			// Define o tipo do recurso a ser utilizado como camera
			imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
			// Indica os tipos de media permitidos pela camera
			imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)!
			// Define seu delegate
			imagePickerController.delegate = self
			// Indica se permite ou nao edicao apos a foto
			imagePickerController.allowsEditing = false
			// Apresenta a viewcontroller da camera
			self.presentViewController(imagePickerController, animated: true, completion: nil);

		} else {
			let alert:UIAlertController = UIAlertController(title: "Erro!", message: "Dispositivo não possui câmera", preferredStyle: UIAlertControllerStyle.Alert);
			alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}

	//MARK: - UIImagePickerControllerDelegate
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		//MARK: - Imagem
		// Recupera a imagem original
		let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		// Caso o modo edicao esteja habilitado (imagePickerController.allowsEditing = true), recupera a imagem editada
//		let img:UIImage = info[UIImagePickerControllerEditedImage] as UIImage

		self.selectedImageView.image = img

		// Para salvar a imagem na biblioteca, usamos:
		UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
		
		//MARK: - Video
		// Recupera o path do video (diferente da imagem o video gera um caminho
//		let moviePath:String = (info[UIImagePickerControllerMediaURL] as NSURL).path!
//		// Salva o video no album
//		if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//			UISaveVideoAtPathToSavedPhotosAlbum (
//				moviePath, nil, nil, nil);
//		}

		picker.dismissViewControllerAnimated(true, completion: nil)
	}

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		picker.dismissViewControllerAnimated(true, completion: nil)
	}

	//MARK: - Memory Management
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

