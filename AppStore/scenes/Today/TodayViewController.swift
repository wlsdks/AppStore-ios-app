//
//  TodayViewController.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

/**
 하단 탭이 투데이일때 보여질 뷰 컨트롤러이다.
 */
final class TodayViewController: UIViewController {
    
    //plist의 값을 가질 변수를 선언한다.
    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() //flowlayout을 초기화 한다.
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        // 레지스터에 사용할 셀 등록
        collectionView.register(TodayCollectionViewCell.self,
                                forCellWithReuseIdentifier: "todayCell"
                                )
        
        collectionView.register(TodayCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TodayCollectionHeaderView"
                                )
        
        return collectionView
    }()
    
    
    // MARK: - 맨 처음 실행됨
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션뷰를 뷰 컨트롤러에 추가
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            // 모서리를 전부 슈퍼뷰에 맞춰줌
            $0.edges.equalToSuperview()
        }
        
        fetchData()
    }
    
    
    
}


// MARK: - collectionView의 데이터 설정을 위한 datasource확장 추가
extension TodayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        
        let today = todayList[indexPath.item]
        cell?.setup(today: today)
        
        return cell ?? UICollectionViewCell() // 혹시라도 닐이면 그냥 초기화한 cell을 보여준다.
    }
    
}

// MARK: - layout설정을 위한 delegate 확장 추가
extension TodayViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - 컬렉션 뷰의 레이아웃 설정1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32.0
        
        return CGSize(width: width, height: width)
    }
    
    // MARK: - 컬렉션 뷰의 레이아웃 설정2
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: 100.0)
    }
    
    // MARK: - 컬렉션 뷰의 레이아웃 설정3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    // MARK: - 컬렉션 뷰의 데이터 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TodayCollectionHeaderView",
                for: indexPath
              ) as? TodayCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.setupViews()
        
        return header
    }
    
    // MARK: - 컬렉션 뷰에서 보여줄 셀(item)이 선택되었을때 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppDetailViewController()
        present(vc, animated: true)
    }
}

// MARK - plist의 데이터를 가져올 확장 선언
private extension TodayViewController {
    func fetchData() {
        // Bundle.main은 프로젝트 내부 경로이다. 파일이름이 "Today"이고 확장자가 "plist"인 것을 값으로 가져온다.
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else { return }
        
        // plist값을 선언한 todayList변수에 주입하는 코드
        do {
            // url에 있는 데이터를 가져와서 담아준다.
            let data = try Data(contentsOf: url)
            // 이 데이터를 decoder로 변환시켜 준다.
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            // 이제 이 클래스가 가진 todayList배열에 변환해준 데이터인 result를 넣어준다.
            todayList = result
        } catch {
            
        }
    }
}
