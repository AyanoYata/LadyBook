import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var writtingButton: UIButton!
    
  
    @IBOutlet weak var tableView: UITableView!
    
    
    //article情報の一覧。ここに全ての情報を保持
    var articles: [Article] = []
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
      //CustomeCellの登録
      let nib = UINib(nibName: "CustomCell", bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: "CustomCell")
      
    }
    
    //画面描画の都度、tableViewを更新処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれた")
        
        dump(articles)
        }
    

    //tableViewのrowの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    //tableViewのCellに表示する内容を返す(indexPathの個数だけ呼ばれる)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Customcell", for: indexPath) as! CustomCell
        if articles.isEmpty == false {
        cell.titleLabel?.text = articles[indexPath.row].title
        }
    return cell
    }
    
    #warning ("tableViewのCellの高さを決める")
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }

    // tableViewのCellがタップされた時に呼ばれる
    
    
    //Firestoreから読み込み
    func readTasksFromFirestore(){
        //let articleId = self.getArticleId()
        //作成日時の降順に並べ替えて取得する
        db.collection("Articles").order(by: "createdAt", descending: true).getDocuments { (querySnapShot, err) in
            if let err = err{
                //エラー時
                print("エラー\(err)")
            } else {
                //データ取得に成功
                //取得したDocument群の1つ1つのDocumentについて処理をする
                for document in querySnapShot!.documents{
                    //各DocumentからはDocumentIDとその中身のdataを取得できる
                    print("\(document.documentID) => \(document.data())")
                }
                // for文を全て回し終えたらリロード
                self.reloadTableView()
            }
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
   
        }
    
    



//func reloadTableview() {tableView.reloadData()
