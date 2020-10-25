import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class WritingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

    
    var articles: [Article] = []
    let db = Firestore.firestore()
    
    
    var editBarButtonItem1: UIBarButtonItem!
    var editBarButtonItem2: UIBarButtonItem!
    
    
    //@IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var writingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleTextView: UITextView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:))))
        
        self.titleTextField.delegate = self
        self.articleTextView.delegate = self
                
        // NavigetionBarにボタンを設置
        editBarButtonItem1 = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(editBarButton1Tapped(_:)))
        editBarButtonItem2 = UIBarButtonItem(title: "< Back", style: .done, target: self, action: #selector(editBarButton2Tapped(_:)))
        
        // ボタンをViewに反映
        self.navigationItem.rightBarButtonItems = [editBarButtonItem1]
        self.navigationItem.leftBarButtonItems = [editBarButtonItem2]
        
        // TextViewに枠線をつける
        articleTextView.layer.borderColor = UIColor.systemGray5.cgColor  //　色
        articleTextView.layer.borderWidth = 1.0 //線の幅
        articleTextView.layer.cornerRadius = 10.0  // 枠を角丸にする
        articleTextView.layer.masksToBounds = true
    }
    
    
    @objc func editBarButton1Tapped(_ sender: UIBarButtonItem) {
        print("【Next】ボタンが押された!")
        //self.performSegue(withIdentifier: "WritingAdd", sender: nil)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WritingAdd") as! WritingAddViewController
        nextVC.titleTextField = titleTextField
        nextVC.articleTextView = articleTextView
        nextVC.writingImageView = writingImageView
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
           let writingAddViewController = navigationController.viewControllers.first as? WritingAddViewController {
            writingAddViewController.titleTextField = titleTextField
            writingAddViewController.articleTextView = articleTextView
            writingAddViewController.writingImageView = writingImageView
        }
    }*/
    
    
    
    @objc func editBarButton2Tapped(_ sender: UIBarButtonItem) {
        print("【< Back】ボタンが押された!")
        //self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    //ImageViewをタップしたときのアクション
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer) {
        print("imageView をタップした")
        // アクションシートを表示
        let alertSheet = UIAlertController(title: nil, message: "選択してください", preferredStyle: .actionSheet)
        //カメラを選んだとき
        let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { action in
            print("カメラが選択されました")
            self.presentPicker(sourceType: .camera)
        }
        //アルバムを選んだとき
        let albumAction = UIAlertAction(title: "アルバムから選択", style: .default) { action in
            print("アルバムが選択されました")
            self.presentPicker(sourceType: .photoLibrary)
        }
        //キャンセルを選んだとき
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { action in
            print("キャンセルが選択されました")
        }
        //それぞれのアクションをひもづける
        alertSheet.addAction(cameraAction)
        alertSheet.addAction(albumAction)
        alertSheet.addAction(cancelAction)
        present(alertSheet, animated: true)
    }
    
        // カメラとアルバムの画面を生成する
        func presentPicker(sourceType:UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                // UIImagePickerControllerのソースタイプが利用できるとき
                let picker = UIImagePickerController()
                picker.sourceType = sourceType
                // デリゲート先はこのclassを指定
                picker.delegate = self
                //画面を表示する
                present(picker, animated: true, completion: nil)
            } else {
                //利用できるソースタイプが無いときはエラー表示
                print("The SourceType is not found")
            }
        }
        
        //撮影 or アルバム を選択したときの処理
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("撮影もしくは画像を選択しました")
            
            if let pickedImage = info[.originalImage] as? UIImage{
                //撮影 or 選択した画像をwritingImageViewの中身に入れる
                writingImageView.image = pickedImage
                writingImageView.contentMode = .scaleAspectFit
            }
            //表示した画面を閉じる
            picker.dismiss(animated: true, completion: nil)
        }
       
    // TitleのKeyboardを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
            return false
        }
    
    // StoryのKeyboardもreturnkeyで閉じる
    func articleTextViewShouldReturn(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            articleTextView.resignFirstResponder()
            return false
        }
        return true
    }


}
 
