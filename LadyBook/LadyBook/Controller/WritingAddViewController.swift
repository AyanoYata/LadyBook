import UIKit
import PKHUD
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI

class WritingAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var articleId: String?
   
    var articles: [Article] = []
    var postDatas: [PostData] = []
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    // TextFieldにPickerで選択したものを反映させる接続
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!
    
    // Pickerの宣言と配列
    var pickerView1: UIPickerView = UIPickerView()
    var array1 = ["Work","Love","Family","Life"]
    
    var pickerView2: UIPickerView = UIPickerView()
    var array2 = ["episode","essay","my history"]
    
    
    //Button
    @IBOutlet weak var releaseButton: UIButton!
    @IBOutlet weak var draftButton: UIButton!
    
    
    var titleTextField =  UITextField()
    var articleTextView = UITextView()
    var writingImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PickerView1の生成
        pickerView1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView1.bounds.size.height)
        // tagでpickerView1を識別
        pickerView1.tag = 1
        pickerView1.delegate   = self
        pickerView1.dataSource = self
        
        let vi1 = UIView(frame: pickerView1.bounds)
        vi1.backgroundColor = UIColor.white
        vi1.addSubview(pickerView1)
        
        // 決定Barの生成
        let toolBar1 = UIToolbar()
        toolBar1.barStyle = UIBarStyle.default
        toolBar1.isTranslucent = true
        toolBar1.tintColor = UIColor.black
        let doneButton1   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(WritingAddViewController.donePressed))
        let spaceButton1  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar1.setItems([spaceButton1, doneButton1], animated: false)
        toolBar1.isUserInteractionEnabled = true
        toolBar1.sizeToFit()
        
        // インプットビューの設定
        categoryTextField.inputView = vi1
        categoryTextField.inputAccessoryView = toolBar1
        
        
        //PickerView2の生成
        pickerView2.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView2.bounds.size.height)
        pickerView2.tag = 2
        pickerView2.delegate   = self
        pickerView2.dataSource = self
        
        let vi2 = UIView(frame: pickerView2.bounds)
        vi2.backgroundColor = UIColor.white
        vi2.addSubview(pickerView2)
        
        
        
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor.black
        let doneButton2   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(WritingAddViewController.donePressed))
        let spaceButton2  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar2.setItems([spaceButton2, doneButton2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        toolBar2.sizeToFit()
        
        styleTextField.inputView = vi2
        styleTextField.inputAccessoryView = toolBar2
        
    }
    
    
    // Done Button
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    // ドラムロールのタイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return array1[row]
        } else {
            return array2[row]
        }
    }
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return array1.count
        } else {
            return array2.count
        }
    }
    
    // ドラムロールで選択した内容を categoryField, StyleFieldに反映させる
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            categoryTextField.text = array1[row]
        } else {
            styleTextField.text = array2[row]
        }
    }
    
    #warning("categoryとstyleの追加")
    //Firestoreへの書き込み(title,text)
    func createToFirestore(_ title:String) -> String {
        //let articleId = self.getArticleId()
        // articleIDに割り振るランダムな文字列を生成
        let articleId = db.collection("Articles").document().documentID
        //  articleIdを使ってArticleのインスタンスを作成
        let article = Article(articleId: articleId, title: title, text: articleTextView.text, createdAt: Timestamp())
        //  Firestoreには、[String:Any]型で記録するため、Task型を変換する ※Encoder()にしないとエラーになるので注意
        do{
            //エラー処理を強制されている関数は、tryをつけて処理する。tryをつけた箇所をdo{}で囲み、do~catch文を使って処理する。
            let encodedArticle:[String:Any] = try Firestore.Encoder().encode(article)
            //変換に成功したとき
            db.collection("Articles").document(articleId).setData(encodedArticle)
            articles.append(article)
        } catch let error as NSError {
            //変換に失敗したとき
            print("エラー\(error)")
        }

        return articleId
    }
    

    // 公開ボタンを押下時の処理
    // FireStoreへ書き込み(StorageにてimageのURLをString型で取得し → 次画面に値を渡し遷移する)
    @IBAction func tapReleaseButton(_ sender: Any) {
        print("⭐️公開ボタンを押しました")
            guard let title = titleTextField.text else {
                return
            }
            //タイトルが空白の時のエラー処理
            if title.isEmpty {
                print(title, "titleが空です！")
                HUD.flash(.labeledError(title: nil, subtitle: "タイトルが入力されていません！"), delay: 1)
                return
            }
            //Firestoreに保存する処理の完成
            let articleId = self.createToFirestore(title)

            if let selectImage = writingImageView.image {
                // 今日日付をintに変換して被らない名前にする
                let imageName = "\(Date().timeIntervalSince1970).jpg"
                // 今回はpostsというフォルダーの中に画像を保存する
                let reference = Storage.storage().reference().child("posts/\(imageName)")
                // 画像データがそのままだとサイズが大きかったりするので、サイズを調整
                if let imageData = selectImage.jpegData(compressionQuality: 0.8) {
                    // メタデータを設定
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    // ①ここでstorageへの保存を行う
                    reference.putData(imageData, metadata: metadata, completion:{(metadata, error) in
                        if let _ = metadata {
                            // ②storageへの保存が成功した場合はdownloadURLの取得を行う
                            reference.downloadURL{(url,error) in
                                if let downloadUrl = url {
                                    // downloadURLの取得が成功した場合
                                    // String型へ変換を行う
                                    let downloadUrlStr = downloadUrl.absoluteString
                                    // ③firestoreへ保存を行う
                                    Firestore.firestore().collection("Articles").document(articleId).setData([
                                        "imageURL": downloadUrlStr,
                                    ], merge: true) { error in
                                        if let error = error {
                                            print(error)
                                        } else {
                                            // firestoreへ保存が成功した場合
                                            HUD.flash(.success, delay: 0.3)

                                            let nextVC = self.storyboard?.instantiateViewController(identifier: "ArticleView") as! ArticleViewController
                                            nextVC.articleId = articleId
                                            self.navigationController?.pushViewController(nextVC, animated: true)
                                        }
                                    }
                                } else {
                                    // downloadURLの取得が失敗した場合の処理
                                }
                            }
                        } else {
                            // storageの保存が失敗した場合の処理
                            print(error!.localizedDescription)
                        }
                    })
                }
            }
        }
}

