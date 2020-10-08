import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseFirestoreSwift

class SecondViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var secondTableView: UITableView!
    
    
    //article情報の一覧。ここに全ての情報を保持
    var articles: [Article] = []
    var postDatas: [PostData] = []
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    
    // 上タブのタイトル
    var itemInfo: IndicatorInfo = "Work"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondTableView.delegate = self
        secondTableView.dataSource = self
        //CustomeCellの登録
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        secondTableView.register(nib, forCellReuseIdentifier: "CustomCell")
    }
    
    
    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Work")
    }
    
    
    //tableViewのrowの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
        //return postDatas.count
    }
    
    //tableViewのCellに表示する内容を返す(indexPathの個数だけ呼ばれる)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
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
