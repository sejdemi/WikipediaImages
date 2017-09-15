import UIKit

class WikipediaImageDisplayVC: UIViewController, UITextFieldDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        searchField.delegate = self
        searchField.addTarget(self, action: #selector(WikipediaImageDisplayVC.textDidChange(_:)), for: UIControlEvents.editingChanged)
    }

    var visibleRows: [Image] {
        var visibleCells: [Image] = []
        if let visibleRows = self.collectionView.indexPathsForVisibleRows {
            visibleRows.forEach {
                visibleCells.append($0.row)
            }
        }
        return visibleCells
    }


    func textDidChange(_ sender: UITextField) {
        WikipediaAPIClient.generateWikipediaImages(for: searchField.text ?? "") {
            (response) in

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - Data Source

    //we only need one section, there are no separate categories of images

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    //we can either return the count of the images in the image array, or hard code it to 50, either way it is the same result

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 50
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! WikipediaImageViewCell
        if cell.delegate == nil { cell.delegate = self as! VisibleCellsProtocol }
        return cell


    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let currentCell = cell as! WikipediaImageViewCell
//        currentCell.im = BookStore.highlander.books[indexPath.row]
//        currentCell.indexPath = indexPath.row
//    }

//        if let url = URL(string: image.thumbnail) {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//                //“promise” forcing this piece of async code to be sync, so it happens in my for loop
//                guard let data = data, error == nil else { return }
//
//                //                DispatchQueue.main.sync() {
//                cell.imageViewCell.image = UIImage(data: data)
////                cell.imageView?.image = UIImage(data: data)
//                //setting that data equal to data of the first image view
//                //                }
//            }
//            DispatchQueue.global(qos: .background).async {
//                
//                task.resume()
//            }
//        }
//        return cell
//    }


}

