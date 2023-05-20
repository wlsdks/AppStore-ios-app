//
//  RankingFeatureSectionView.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

/**
 랭킹섹션 코드 추가
 */
final class RankingFeatureSectionView: UIView {
    
    // RankingFeature데이터를 담아줄 변수를 선언
    private var rankingFeatureList: [RankingFeature] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .black)
        label.text = "iPhone이 처음이라면"
        
        return label
    }()
    
    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(RankingFeatureSectionViewCell.self, forCellWithReuseIdentifier: "RankingFeatureCollectionViewCell")
        
        return collectionView
    }()
    
    // separatorView선언
    private let separatorView = SeparatorView(frame: .zero)
    
    // 꼭 init메서드로 setupViews()를 실행시켜줘야 한다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        fetchData() // 데이터 추가
        collectionView.reloadData() // 컬렉션 뷰 리로드 실시(데이터가 보이게 해야함)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankingFeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: RankingFeatureSectionViewCell.height)
    }
}

extension RankingFeatureSectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rankingFeatureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureCollectionViewCell", for: indexPath) as? RankingFeatureSectionViewCell
        
        let rankingFeature = rankingFeatureList[indexPath.item]
        cell?.setup(rankingFeature: rankingFeature)
        
        return cell ?? UICollectionViewCell()
    }
    
}

// MARK: - 랭킹 섹션을 설정하는 확장 선언
private extension RankingFeatureSectionView {
    
    func setupViews() {
        [
            titleLabel,
            showAllAppsButton,
            collectionView,
            separatorView
        ].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
        }
        
        showAllAppsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            $0.height.equalTo(RankingFeatureSectionViewCell.height * 3) // 조금 더 많은 앱을 보여주고싶다면 여기서 *4 이런식으로 수정하면 된다.
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    // ranking 데이터를 세팅하는 함수
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else { return }
        
        // 데이터를 주입
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            
            self.rankingFeatureList = result
        } catch {}
    }
    
}
