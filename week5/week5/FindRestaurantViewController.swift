
import UIKit
import Alamofire
class FindRestaurantViewController: UIViewController {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage(named: "pageControll1.jpeg")!, UIImage(named: "pageControll2.jpeg")!, UIImage(named: "pageControll3.jpeg")!, UIImage(named: "pageControll4.jpeg")!, UIImage(named: "pageControll5.jpeg")!, ]
    var imageView = [UIImageView]()
    private var data = Data()
    
    private var RestaurantInfo = [Datum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.fetchRestaurantInfo { [weak self] result in
            guard let self = self else {return;}
//            switch result {
//            case let .success(result):
//               debugPrint("Success : \(result)")
//
//
//            case let .failure(error):
//               debugPrint("error : \(error)")
//            }
        }
        
        addContentScrollView()
        setPageControl()
        registerNib()
        setupFlowLayout()
    }
    
    private func makeFindRestaurantList(welcome : Welcome) -> [Datum]{
        return welcome.data;
    }
    
    private func fetchRestaurantInfo(
        complitionHandler: @escaping (Result<Welcome, Error>) -> Void
    ){
        let url = "https://api.odcloud.kr/api/15066516/v1/uddi:507e01f5-76ec-42ff-96a5-8b6ff9ce554e?page=1&perPage=100&serviceKey=fowOB%2Bj2tJTM0JKO5%2BmliF2O4FEIr8fhNrfitZkFFlbh%2Bfrz5s5IFdEcQIpnSIDgvBBxYs2vA1hO%2B8IptUxNtA%3D%3D"
        
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
        
            
        request.responseDecodable(of:Welcome.self){response in
            guard let info = response.value else {return;}
            for idx in info.data{
                self.RestaurantInfo.append(idx)
            }
            
        }.resume()
    }
    
    
    private func registerNib() {
        collectionView.register(UINib(nibName: "FindResCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FindResCollectionViewCell")
    }
    
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 2
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9 , height: halfWidth * 0.9)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    
    
    
}

extension FindRestaurantViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}


extension FindRestaurantViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.imageArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindResCollectionViewCell", for: indexPath) as?
                UICollectionViewCell else {return UICollectionViewCell()}
        
        
        
        
        return cell;
    }
}
