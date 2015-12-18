//
//  ViewController.swift
//  Nube_semana2_tarea1.0
//
//  Created by Luis Rufino Perez Romero on 12/17/15.
//  Copyright © 2015 Luis Perez Romero. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate, ParsingManagerDelegate {
    
    let URL_String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    @IBOutlet weak var textFieldISBN: UITextField!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var imagePortada: UIImageView!
    var parser: ParsingManager?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textFieldISBN.delegate = self
        textFieldISBN.returnKeyType = .Search
        parser = ParsingManager()
        parser!.delegate = self
        
        imagePortada.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let inputISBN = textField.text {
            requestISBN(inputISBN)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func requestISBN(ISBN: String) {
        let urlRequest = URL_String + ISBN
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlRequest)
        
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                dispatch_async(dispatch_get_main_queue(), {
                    self.showErrorAlert("Network Error", error: error!.localizedDescription)
                })
            }
            else {
                self.parser!.parse(ISBN, data: data!)
            }
        }
        
        task.resume()
    }
    
    
    func parsingManager(parsingManager: ParsingManager, didParseBook book: Book) {
        if !book.titulo.isEmpty {
            self.lblTitulo.text = book.titulo
            self.lblAutor.text = book.autores
            self.imagePortada.image = book.portada
        } else {
            self.lblTitulo.text = ""
            self.lblAutor.text = ""
            self.imagePortada.image = nil
            self.showErrorAlert("Error", error: "El ISBN ingresado no existe")
        }
    }
    
    
    func showErrorAlert(title: String , error: String) {
        let alert = UIAlertController(title: title, message: error, preferredStyle: .Alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
        alert.addAction(dismiss)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
