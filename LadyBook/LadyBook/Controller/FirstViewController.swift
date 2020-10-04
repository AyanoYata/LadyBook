import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirstViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    
  
    @IBOutlet weak var firstTableView: UITableView!
    
    
    //article情報の一覧。ここに全ての情報を保持
    var articles: [Article] = []
    var postDatas: [PostData] = []
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    // 上タブのタイトルボタン
    var itemInfo: IndicatorInfo = "Top"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstTableView.delegate = self
        firstTableView.dataSource = self
        //CustomeCellの登録
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        firstTableView.register(nib, forCellReuseIdentifier: "CustomCell")
      
    }
    
    

    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    //画面描画の都度、tableViewを更新処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれた")
        
        dump(articles)
        dump(postDatas)
        }
    
    
    //tableViewのrowの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
        //return postDatas.count
    }
    
    #warning("postDatasの内容はどう返せばいいのか")
    //tableViewのCellに表示する内容を返す(indexPathの個数だけ呼ばれる)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Customcell", for: indexPath) as! CustomCell
        if articles.isEmpty == false {
        cell.titleLabel?.text = articles[indexPath.row].title
        }
    return cell
    }
    
   //tableViewのCellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }

    // tableViewのCellがタップされた時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:", indexPath)
        let vc = ArticleViewController()
        #warning("タップされたらFireStoreの値をの ArticleViewControllerへ 渡す")
        //vc.articleInfo =
        // 画面遷移
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    #warning("Firestoreから読み込み")
    func readTasksFromFirestore(){
       
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
                //self.reloadTableView()
            }
        }
    }
    
    //func reloadTableView() {
        //tableView.reloadData()
    }
    
   
        
    
    
