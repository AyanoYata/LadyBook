import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI
import Nuke


class ArticleViewController: UIViewController, UITabBarDelegate {
    
    
    var articleId: String?
    
    var articles: [Article] = []
    var postDatas: [PostData] = []
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    private var myTabBar:MyTabBar!
    
    @IBOutlet weak var writingImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
   
    
   
   // @IBOutlet weak var selectedCategoryTextField: UITextField!
    //@IBOutlet weak var selectedStyleTextField: UITextField!
    @IBOutlet weak var imageRateLayoutConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigetionBarデフォルトのBackボタンを非表示にする
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //  db.collection("Articles").document(articleId!).getDocumentで、articleIdのデータを取り出し表示する
        db.collection("Articles").document(articleId!).getDocument { (documentSnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let documentSnapshot = documentSnapshot {
                
                let data = documentSnapshot.data()
                
                self.titleLabel.text = data?["title"] as? String
                self.articleLabel.text = data?["text"] as? String
                //self.selectedCategoryTextField.text = data?["category"] as? String
                //self.selectedStyleTextField.text = data?["style"] as? String
                
                //imageURLをwritingImageViewに反映させる
                if let imageURL = data?["imageURL"] as? String {
                    Nuke.loadImage(with: URL(string: imageURL)!, into: self.writingImageView)
                    
                    Nuke.loadImage(with: URL(string: imageURL)!, options: ImageLoadingOptions(), into: self.writingImageView, progress: nil) { (result: Result<ImageResponse, ImagePipeline.Error>) in
                        
                        switch result {
                        case .success(let imageResponse):
                            self.imageRateLayoutConstraint.constant = imageResponse.image.size.width / imageResponse.image.size.height
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
        
        // 下 TabBarを設置
        let width = self.view.frame.width
        let height = self.view.frame.height
        let tabBarHeight:CGFloat = 58
        
        
        myTabBar = MyTabBar()
        //バーの枠組
        myTabBar.frame = CGRect(x:0,y:height - tabBarHeight,width:width,height:tabBarHeight)
        //バーの色
        myTabBar.barTintColor = UIColor.systemGray4
        //選択されていないボタンの色
        myTabBar.unselectedItemTintColor = UIColor.white
        //ボタンを押した時の色
        myTabBar.tintColor = UIColor.systemPink
        
        //ボタンを生成(文字と画像)
        let config1:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named:"home.png"), tag: 1)
        let config2:UITabBarItem = UITabBarItem(title: "Search", image: UIImage(named:"search.png"), tag: 2)
        let config3:UITabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named:"heart.png"), tag: 3)
        let config4:UITabBarItem = UITabBarItem(title: "Mypage", image: UIImage(named:"person.png"), tag: 4)
        
        //ボタンをタブバーに配置する
        myTabBar.items = [config1,config2,config3,config4]
        //デリゲートを設定する
        myTabBar.delegate = self
        
        self.view.addSubview(myTabBar)
        //バーの色①
        myTabBar.barTintColor = UIColor.lightGray
        //選択されていないボタンの色②
        myTabBar.unselectedItemTintColor = UIColor.white
        
        myTabBar.items = [config1,config2,config3,config4]
        
        
        // 各Tabの動き
        func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag{
            case 1:
                let nextVC = storyboard?.instantiateViewController(identifier: "First")
                self.present(nextVC!, animated: true, completion: nil)
            
            //case 2:
                
            //case 3:
                
            //case 4:
                
            
            default : return
                
            }
        }
        
    }
    
   
}

