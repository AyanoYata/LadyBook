import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseFirestoreSwift

class ThirdViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
   

    
   
    @IBOutlet weak var thirdTableView: UITableView!
    
    
    //article情報の一覧。ここに全ての情報を保持
    var articles: [Article] = []
    var postDatas: [PostData] = []
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    
    // 上タブのタイトル
    var itemInfo: IndicatorInfo = "Love"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        thirdTableView.delegate = self
        thirdTableView.dataSource = self
        //CustomeCellの登録
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        thirdTableView.register(nib, forCellReuseIdentifier: "CustomCell")
        
    }
    
    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Love")
    }
    
    //画面描画の都度、tableViewを更新処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれた")
        
        dump(articles)
        dump(postDatas)
        }
    
    
    // TableViewCellを読み込む関数
    func configureTableViewCell() {
        // TableViewCellのクラス名を指定してNibを作成
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        // Xibに設定したidentifier
        let cellID = "CustomCell"
        // TableViewCellにcellのIdentifierを指定して登録
        thirdTableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    
    //tableViewのrowの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
        //return postDatas.count
    }
    
    //tableViewのCellに表示する内容を返す(indexPathの個数だけ呼ばれる)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        if articles.isEmpty == false {
        cell.titleLabel?.text = articles[indexPath.row].title
        }
    return cell
    }
    
   //tableViewのCellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    
}
