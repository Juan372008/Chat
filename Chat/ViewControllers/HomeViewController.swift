//
//  HomeViewController.swift
//  Chat
//
//  Created by Juan Gallo on 3/5/21.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController
                           
 {
   
    
    
    
    
    
    
    
    
    
    

        
        
        
       
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
//    private var photo = Photo()
    
   var photos = [Photo]()
     var notesModel = NotesModel()
    
    var users = Usuario()
    
    var notes = [Note]()
    
    var notas = [Note]()
    
     var note = Note()
    
     var order = Order()
    
     var photoTwoArrayMain = [PhotoTwo]()
    
    var userArray = [PhotoUser]()
    
     var emailValor:String?

    var correo:String = " "
    
    var mail:String?
    
    var control:String?
    
    var controlLogin:String?
    
    var valor:String?
    
    var counter = 0
    
     var fotoBuena = [PhotoTwo]()
    
    var login = LoginViewController()
    
     var l = PhotoTwo(photoId: "", byId: "", byUsername: "", date: "", url: "")
    var n = PhotoTwo(photoId: "", byId: "", byUsername: "", date: "", url: "")
    
    var u = PhotoUser(userId: "", username: "", uid: "")
    
    var emailDeCasa:String = "Email inicializado"
    
    var noPriorityArray = [Note]()
    var lowPriorityArray = [Note]()
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControl()


        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.notesModel.delegate = self
        self.notesModel.getNotes()
        
        controlLogin = control
        
        if controlLogin == nil {
            
        self.correo = emailValor ?? "jg@jg.com"
        }
        else {
            self.correo = valor ?? "jd@jd.com"
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        
        order.autorizado { l in

            self.photoTwoArrayMain  = l
            self.tableView.reloadData()
            
        }
        users.usuarios { u in
            self.userArray = u
            self.tableView.reloadData()
        }
        
//        awakeFromNib()

    }
    
    
    
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func addRefreshControl() {
        
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        self.tableView.addSubview(refresh)
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        order.autorizado { (newPhotos) in
            self.photoTwoArrayMain = newPhotos

      

            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
            }
        }
    


    
    
    @IBAction func exitTapButton(_ sender: Any) {
        
        
        
        
        do {
        try Auth.auth().signOut()
        
        LocalStorageService.clearUser()
        
            let loginNavVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavController)
            
            self.view.window?.rootViewController = loginNavVC
            self.view.window?.makeKeyAndVisible()
        }
        catch {
            
        }

    }
    
    @IBAction func submitButton(_ sender: Any) {
        
             
        let n = Note(docId: UUID().uuidString, body: textField.text ?? "", createdAt: Date())
        self.note = n
        notes.append(note)
        
        
            
        
        
        self.notesModel.saveNote(self.note)
    }
    
    }

        

    
extension HomeViewController: NotesModelProtocol {
    func notesRetrieved(notes: [Note]) {
        self.notes = notes
        
        tableView.reloadData()
    }
}
    
extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCellId, for: indexPath) as? PhotoCell
        
        for n in photoTwoArrayMain{
//            for h in userArray{
                if n.byUsername == correo{
                    self.fotoBuena.append(n)
                
//            }
                
            }
        }
        if self.fotoBuena.count != 0 {
        let photo = self.fotoBuena[indexPath.row]
        
        cell?.displayPhoto(photo: photo)
        }
        let bodyLabel = cell?.viewWithTag(1) as? UILabel
        
        bodyLabel?.text = notes[indexPath.row].body
        
        return cell!
        
    }
}
    
    
   
    
    
    



    
   

