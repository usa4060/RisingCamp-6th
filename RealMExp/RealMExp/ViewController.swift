//
//  ViewController.swift
//  RealMExp
//
//  Created by admin on 2022/05/30.
//

import RealmSwift
import UIKit

class ContactItem : Object{     // Object타입은 Realm에 쓸 객체를 나타내는 타입이다.
    
    @objc dynamic var name = ""
    // 변수가 dynamic타입인 이유는, runtime에 생성/제거 될 수 있어야 하기 때문이다. data가 생기고 지워질 때 이를 가능하게 하기 위해서 dynamic인 듯,,,?
    
    @objc dynamic var telephoneNumber = ""
    
    
    @objc dynamic var _id : ObjectId = ObjectId.generate()
    // 해당 property가 key로 사용 될 예정이기 때문에 ObjectId로 생성해준다 (대충 무작위 번호 같으 느낌,,,?)
    
    convenience init(name : String, telephoneNumber : String, _id : String){
        self.init()
        self.name = name
        self.telephoneNumber = telephoneNumber
    }
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

class ViewController: UIViewController {

    let yongIn = ContactItem(name: "yongIn", telephoneNumber: "010-8350-9172", _id: "980501-XXXXXXX" )
    
    var people = try! Realm().objects(ContactItem.self).sorted(byKeyPath: "name", ascending: true)
    // 해당 구문은 본질적으로는 쿼리문이다!!
    // 이처럼 Realm DB에 접근하기위해선 (정보확인) Realm().Object(name.self)로 접근해야 한다.
    // try ~ catch로 해야하는 이유는, 실제 가져오려는 데이터가 존재하지 않을 수 도 있기 때문에,,,,
    // 따라서 해당 구문은, 쿼리문의 일종으로 people을 통해 ContactItem이라는 DB에 접근하여 name에 따라서 Sort를 한다는 의미를 가진다.
    
    var realm = try! Realm()
    // Create, Read, Update, Delete를 하기 위해선 이와 같이 Realm의 권한으로 접근 해줘야 한다.
    // people은 단순히 해당 DB에 정보를 읽어오기 위함이다.
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if realm.isEmpty{
            //realm이라는 객체가 비어있으면 yongIn이라는 객체를 하나 채워준다.
            try! realm.write({
                realm.add(yongIn)
            })
        }
        let path = realm.configuration.fileURL?.path
        print(path as Any) // 이를통해 db가 저장되어 있는 장소를 볼 수 있는데, 파일의 형식이 Realm 형식인 것을 알 수 있다.
        
        
    }
   
    @IBAction func addButtonTapped(_ sender: Any) {
        let alterController = UIAlertController(title: "Add Contact", message: "", preferredStyle: .alert)
        
        // 유저가 add버튼을 클릭 했을 때, 해당 dialog를 보여준다.(이름과 번호를 입력하는 textField)
        alterController.addAction(UIAlertAction(title: "Save", style: .default, handler: { Void in
            let nameField = alterController.textFields![0] as UITextField
            let teleField = alterController.textFields![1] as UITextField
            
        // textField에 입력한 정보들을 사용하여 새로운 ContactItem 정보를 만들어낸다.
            
            let newPerson = ContactItem(name: nameField.text!, telephoneNumber: teleField.text!, _id: "")
        // 여기서 _id는 따로 지정하지 않는 이유는, 해당 객체를 생성할 때 _id는 ObjectId를 통해 자동으로 랜덤값이 지정되기 때문이다.
            
            
        
        // RealM에서의 모든 추가,업데이트,삭제 작업은 write-block에서 이뤄진다!!
        //  -> 제일 중요한 부분이야~!~!~!
            
            try! self.realm.write({
                self.realm.add(newPerson)
                // add()함수를 통해 새로운 데이터를 추가한다.
                self.tableView.reloadData()
                // 추가했으니 tableView를 reload해 줘야한다.
            })
            
        }))
        
        alterController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alterController.addTextField(configurationHandler: {
            (nameField : UITextField) -> Void in
            nameField.placeholder = "New Contact Name"
        })
        alterController.addTextField(configurationHandler: {
            (teleField : UITextField) -> Void in
            teleField.placeholder = "+1 (111) 111-1111"
        })
        
        // alter 보여주기
        self.present(alterController, animated: true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        try! realm.write({
            self.realm.deleteAll()  // DB에 있는 모든 내용 삭제
        })
        self.tableView.reloadData() // 삭제 했으니 tableView 리로드
    }
    
}

extension ViewController : UITableViewDelegate{
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = people[indexPath.row].telephoneNumber
        return cell
    }
    
    
}
