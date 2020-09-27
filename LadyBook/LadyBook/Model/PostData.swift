import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI


class PostData: NSObject {
    
    var id: String
    var imageURL: String?
    var date: Date?
    
    
    init(document: QueryDocumentSnapshot) {
        
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.imageURL = postDic["imageURL"] as? String
        
        let timestamp = postDic["createdAt"] as? Timestamp
        
        self.date = timestamp?.dateValue()
    }
    
    
}
