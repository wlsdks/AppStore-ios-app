//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

final class FeatureSectionView: UIView {
    
    // feature데이터를 받을 배열 선언
    private var featureList: [Feature] = []
    
    // MARK: - collectionView를 선언한다. 이건 앱 맨 상단에 있는 section에 사용되는 View다.
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        // 이 collectionview는 가로로 스크롤이 가능해야함
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        // collectionview가 가로로 스크롤했을때 pagination이 되도록 한다.
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        // scroll바는 감추도록 한다.
        collectionView.showsHorizontalScrollIndicator = false
        
        // 셀 사용을 위한 register등록 -> identifier등록을 코드로 하는 방법
        collectionView.register(
            FeatureSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell"
        )
        
        return collectionView
    }()
    
    // separatorView를 프로퍼티로 선언
    private let separatorView = SeparatorView(frame: .zero)
    
    // ViewController가 아닌 UIView 클래스라 ViewDidLoad가 아닌 init(생성자)으로 설정해 준다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 뷰 세팅 실시
        setupViews()
        
        // 데이터를 가져온다.
        fetchData()
        collectionView.reloadData() // 리로드를 한번 해준다.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(corder:) has not been implemented")
    }
}

extension FeatureSectionView: UICollectionViewDataSource {
    
    // 셀의 갯수를 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        featureList.count
    }
    
    // 셀의 상세설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        
        // feature세팅하고 넣어준다.
        let feature = featureList[indexPath.item]
        cell?.setup(feature: feature)
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout {
    
    // 각각 셀의 사이즈를 설정해주는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        // 양쪽에 마진 16을 줘야해서 전체 슈퍼뷰에서 16*2=32라서 32를 빼줬다.
        CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
        
    }
    
    // inset에서도 left, right값을 설정해줬다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        // 중앙정렬을 위해서 이 코드가 필요하다.
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
    }
    
    // section의 최소 마진을 설정한다. -> 여기선 32로 설정함
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        32.0
        
    }
    
}

private extension FeatureSectionView {
    
    // view를 세팅한다.
    func setupViews() {
        [
            collectionView,
            separatorView // collectionView하단에 경계선 뷰인 separatorView추가
        ].forEach { addSubview($0) }
        
        // collectionView 레이아웃 설정
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
        
        // separatorView 레이아웃 설정
        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
        
        
    }
    
    // MARK: - Feature데이터를 plist에서 받아와서 사용할 메서드
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        } catch {
            
        }
    }
    
    
}
