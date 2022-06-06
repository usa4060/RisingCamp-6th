import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    
    
    var swordImageArray : [UIImage] = [UIImage(named: "level1_sword.png")!,UIImage(named: "level2_sword.png")!,
                                       UIImage(named: "level3_sword.png")!,UIImage(named: "level4_sword.png")!,
                                       UIImage(named: "level5_sword.png")!,UIImage(named: "level6_sword.png")!]         // level에 따른 검의 이미지
    var monsterImageArray : [UIImage] = [UIImage(named: "level2_monster.png")!,UIImage(named: "level2_monster.png")!,
                                         UIImage(named: "level3_monster.png")!,UIImage(named: "level4_monster.png")!,
                                         UIImage(named: "level5_monster.png")!,UIImage(named: "level6_monster.png")!]   // level에 따른 monster 이미지
    var backgroundImageArray : [UIImage] = []   //  level에 따른 background 이미지
    var fieldMonster : [UIImageView] = []       //  현재 field에 나와있는 몬스터를 확인하는 배열
    
    var timer : Timer?
    var count : Int = 60        // 게임 진행시간을 60sec으로 맞춤
    var score : Int = 0         // 0점 시작으로 초기화
    var level : Int = 1         // 최초 레벨은 1시작
    var mode : String = "EASY"  // Mode default값은 EASY
    var attackCount : Int = 0       // 공격 횟수를 저장
    var startBoolean : Bool = true  // 게임 최초 실행인지 확인
    var isMonsterDead : Bool = false // 몬스터가 죽은 상태인지 확인
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var alphaView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startMainViewController()
    }
    
    
    //MARK: - MainViewController에 들어오면 처음 보게되는 모습
    func startMainViewController(){
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.7
    }
    
    //MARK: - 게임모드가 Easy모드인지 Hard모드인지 확인
    func checkMode(){
        if(mode == "EASY"){
            self.startGame(difficulty: self.mode)
        }
        else{
            // Hard모드는 차후에 업데이트
        }
    }
    
    //MARK: - 게임이 시작되고 난이도에 따라 여러 메서드들을 시작하는 함수
    func startGame(difficulty : String){
        if (difficulty == "EASY"){
            generateMonsterEASY(monsterCount: fieldMonster.count)
            // 타이머 시작
            // 음악 시작
            // 이 기능들이 들어가는 공간임
        }
        else if (difficulty == "HARD"){
            // Hard 모드는 차후에 업데이트
        }
        
    }
    
    
    //MARK: - 현재 남아있는 몬스터에 따라 나머지 몬스터 생성하는 함수   (UI가 변경되므로 global -> main Queue 사용)
    func generateMonsterEASY(monsterCount : Int){
        if(monsterCount == 0){                                                                      // 몬스터를 2마리 소환
            DispatchQueue.global(qos: .userInitiated).async {
                for _ in 0...1{
                    DispatchQueue.main.async {
                        var monsterView : UIImageView!
                        let frame = CGRect(x: 354, y: 676, width: 60, height: 100)
                        monsterView = UIImageView(frame: frame)
                        monsterView.image = self.monsterImageArray[self.level-1]
                        self.view.addSubview(monsterView!)                                          // 몬스터 생성
                        self.fieldMonster.append(monsterView)                                       // 필드에 나와있는 몬스터 목록에 추가
                        self.moveImage(start: frame.minX, index: self.fieldMonster.count - 1 )      // 몬스터가 위치한 x좌표를 기준으로 움직이기 시작
                        print("2마리 소환하는 generator야")
                        print("방금 소환해서 지금은 \(self.fieldMonster.count)마리 소환되어 있어!!")
                    }
                    usleep(1000000)                                                                 // 몬스터 생성 간격 1sec
                }
            }
        }
        else if(monsterCount == 1){                                                                 // 몬스터 1마리 소환
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    var monsterView : UIImageView!
                    let frame = CGRect(x: 354, y: 676, width: 60, height: 100)
                    monsterView = UIImageView(frame: frame)
                    monsterView.image = self.monsterImageArray[self.level-1]
                    self.view.addSubview(monsterView!)                                              // 몬스터 생성
                    self.fieldMonster.append(monsterView)                                           // 필드에 나와있는 몬스터 목록에 추가
                    self.moveImage(start: frame.minX, index: self.fieldMonster.count - 1 )          // 몬스터가 위치한 x좌표를 기준으로 움직이기 시작
                    print("1마리 소환하는 generator야")
                    print("방금 소환해서 지금은 \(self.fieldMonster.count)마리 소환되어 있어!!")
                    
                }
            }
        }
    }
    
    
    //MARK: - 몬스터가 처치 되었을 때 동작하는 함수 (UI가 변경되므로 global -> main Queue 사용)
    func killMonster(){
        DispatchQueue.global(qos:.userInitiated).async {
            DispatchQueue.main.async {
                self.isMonsterDead = true                                   // 몬스터는 죽었다!
                self.fieldMonster[0].removeFromSuperview()                  // 가장 앞에 있는 필드 몬스터를 삭제한다.
                self.fieldMonster.remove(at: 0)                             // 필드 몬스터 배열에서도 지워준다.
                print("killMonster에서 몬스터 없애서 현재 남은 몬스터는 \(self.fieldMonster.count)마리")
            }
        }
        generateMonsterEASY(monsterCount: fieldMonster.count)               // 필드 몬스터를 다시 소환한다.
        self.isMonsterDead = false                                          // 이제 다시 몬스터는 살아있다!
        print("killMonster에서 몬스터 소환하는 중")
        
    }
    
    
    //MARK: - 몬스터가 필드에서 주인공에게로 이동하는 것을 구현하는 함수 (UI가 변경되므로 global -> main Queue 사용)
    func moveImage(start: CGFloat, index: Int){
        var moveX = start
        DispatchQueue.global(qos: .userInitiated).async {
            while(moveX > 0){
                moveX -= 1
                DispatchQueue.main.async {
                    if(index >= self.fieldMonster.startIndex && index < self.fieldMonster.endIndex){
                        self.fieldMonster[index].frame = CGRect(x: moveX, y: 676, width: 60, height: 100)
                    }
                    else {return;}
                }
                usleep(16666)                                   // 이동속도를 담당 ()
            }
        }
    }
    
    
    
    //MARK: - '게임 시작' 버튼을 눌렀을 때, 해당하는 action을 취하는 함수
    @IBAction func startBtnTapped(_ sender: UIButton) {
        startBtn.isHidden = true    // '게임 시작' 버튼을 숨겨준다.
        alphaView.isHidden = true
        checkMode()
    }
    
    
    //MARK: - 공격버튼을 눌렀을때, 해당하는 action을 취하는 함수
    @IBAction func attackBtnTapped(_ sender: UIButton) {
        attackCount+=1
        print(attackCount)
        if(attackCount == 10){
            killMonster()
            attackCount = 0
        }
    }
    
    
    
}

