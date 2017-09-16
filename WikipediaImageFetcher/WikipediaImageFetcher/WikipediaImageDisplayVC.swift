import UIKit
import Kingfisher

//I have a general rule where I try to keep my ViewControllers at 100 or less lines. It's why I learned MVVM in the last few weeks because I am trying to avoid issues with Massive-View-Controllers.

class WikipediaImageDisplayVC: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    var allImages = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(WikipediaImageDisplayVC.textDidChange(_:)), for: UIControlEvents.allEvents)
    }

    //our selector function which is handling any changes made in the text field to trigger an API call, which is then altering out allImages variable
    func textDidChange(_ sender: UITextField) {

        WikipediaAPIClient.generateWikipediaImages(for: searchField.text ?? "") {
            (response) in
            switch response {
            case .success(let responseImages):
                self.allImages = responseImages
            case .failure(let error):
                print(error.localizedDescription)

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
    }

    // MARK: - Data Source

    //we only need one section, there are no separate categories of images

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    //we can either return the count of the images in the image array, or hard code it to 50, either way it is the same result

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }




    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! WikipediaImageViewCell
        //use kingfisher to set images
        if let url = URL(string: allImages[indexPath.item].thumbnail) {
            cell.imageViewCell.kf.setImage(with: url, placeholder: UIImage(named: "black texture"))
        }

        //animate frames so it appears that cells are flying in and out
        let finalFrame: CGRect = cell.frame
        cell.frame = CGRect(x: finalFrame.origin.x - 1000, y: -500, width: 200, height: 200)

        UIView.animate(withDuration: 1, animations: {
            cell.frame = finalFrame

        })

        return cell
    }
}
