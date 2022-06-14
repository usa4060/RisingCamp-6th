import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    
    var bgImageArray : [UIImage] = [UIImage(named: "level1_bg.png")!,UIImage(named: "level2_bg.png")!,
                                    UIImage(named: "level3_bg.png")!,UIImage(named: "level4_bg.png")!,
                                    UIImage(named: "level5_bg.png")!,UIImage(named: "level6_bg.png")!]
    var swordImageArray : [UIImage] = [UIImage(named: "level1_sword.png")!,UIImage(named: "level2_sword.png")!,
                                       UIImage(named: "level3_sword.png")!,UIImage(named: "level4_sword.png")!,
                                       UIImage(named: "level5_sword.png")!,UIImage(named: "level6_sword.png")!]         // level에 따른 검의 이미지
    var monsterImageArray : [UIImage] = [UIImage(named: "level1_monster.png")!,UIImage(named: "level2_monster.png")!,
                                         UIImage(named: "level3_monster.png")!,UIImage(named: "level4_monster.png")!,
                                         UIImage(named: "level5_monster.png")!,UIImage(named: "level6_monster.png")!]   // level에 따른 monster 이미지
    var backgroundImageArray : [UIImage] = []   //  level에 따른 background 이미지
    var fieldMonster : [UIImageView] = []       //  현재 field에 나와있는 몬스터를 확인하는 배열
    
    var swordValue : Int = 0; // 검 이미지 변경값
    var deathCountMonster : Int = 0; // 몬스터의 데스 카운터
    var countTimer : Timer?
    var counter : Float = 0        // 게임 진행시간을 60sec으로 맞춤
    var score : Int = 0         // 0점 시작으로 초기화
    var level : Int = 1         // 최초 레벨은 1시작
    var deathCountUser : Int = 0          // 죽은 횟수
    var mode : String = "EASY"  // Mode default값은 EASY
    var attackCount : Int = 0       // 공격 횟수를 저장
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var deathCountLabel: UILabel!
    @IBOutlet weak var swordView: UIImageView!
    @IBOutlet weak var stageLevelLable: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timeProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startMainViewController()
        self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTimerText), userInfo: nil, repeats: false)
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
            generateMonsterEASY()
            // 타이머 시작
            // 음악 시작
            // 이 기능들이 들어가는 공간임
        }
        else if (difficulty == "HARD"){
            // Hard 모드는 차후에 업데이트
        }
        
    }
    
    @objc func changeTimerText(){
        if counter != 0 {
            self.timerLabel.text = "00 : \(String(format: "%02d", counter))"
            self.counter -= 1
            self.timeProgressView.progress = 60/self.counter
            print("남은 COUNTER : \(self.counter)")
            if counter < 0.0 { countTimer?.invalidate() }
        } else {
            //endEffect() // 음악 정지, 타이머 종료(메모리 해제)
            print("Timer End")
            
            
            
            // 최종 결과로 이동.(점수 전달해야함.)
            // let finishVC = (self.storyboard?.instantiateViewController(withIdentifier: "FinishVC")) as! FinishViewController
            // finishVC.text = "\(String(score + (60 - counter)))점" // 점수 전달
            // self.navigationController?.pushViewController(finishVC, animated: true)
        }
    }
    
    //MARK: - 현재 남아있는 몬스터에 따라 나머지 몬스터 생성하는 함수   (UI가 변경되므로 global -> main Queue 사용)
    func generateMonsterEASY(){
        DispatchQueue.global(qos: .userInitiated).async {
            while(true){                                                                    // fieldMonster의 수에 따라 generater가 계속 진행
                if(self.fieldMonster.count != 1){
                    self.makeMonster()
                    usleep(1500000)
                }
            }
        }
    }
    
    //MARK: - 필드에 몬스터를 추가 해주는 함수
    func makeMonster(){
        DispatchQueue.main.async {
            var monsterView : UIImageView!
            let frame = CGRect(x: 354, y: 700, width: 60, height: 100)
            monsterView = UIImageView(frame: frame)
            monsterView.image = self.monsterImageArray[self.level-1]
            self.view.addSubview(monsterView!)                                          // 몬스터 생성
            self.fieldMonster.append(monsterView)                                       // 필드에 나와있는 몬스터 목록에 추가
            self.moveImage(start: frame.minX, index: self.fieldMonster.count - 1 )      // 몬스터가 위치한 x좌표를 기준으로 움직이기 시작
        }
        return;
    }
    
    //MARK: - 몬스터가 필드에서 주인공에게로 이동하는 것을 구현하는 함수 (UI가 변경되므로 global -> main Queue 사용)
    func moveImage(start: CGFloat, index: Int){
        // print("moveImage")
        var moveX = start
        DispatchQueue.global(qos: .userInteractive).async {
            while(moveX > 50){
                if self.attackCount == 10{
                    return self.killMonster()                 // 몬스터 공격 당할 때
                }
                else{
                    moveX -= 1
                    DispatchQueue.main.async {
                        if(index >= self.fieldMonster.startIndex && index < self.fieldMonster.endIndex){
                            self.fieldMonster[index].frame = CGRect(x: moveX, y: 700, width: 60, height: 100)
                        }
                        else {
                            self.fieldMonster[index - 1].frame = CGRect(x: moveX, y: 700, width: 60, height: 100)         // remove되서 index가 변경 된
                        }                                                                                               // 몬스터를 이동시켜 줌
                    }
                    usleep(useconds_t(16666 - (2500*(self.level - 1))))                              // 이동속도를 담당 ()
                }
            }
            self.attackCount = 0
            self.deathCountUser += 1
            return self.removeMonster()                     // 몬스터가 캐릭터랑 만나서 사라질 때
        }
    }
    
    //MARK: - 몬스터가 처치 되었을 때 동작하는 함수
    func killMonster(){
        print("killMonster")
        DispatchQueue.global(qos:.userInteractive).sync{
            self.removeMonster()
        }
        self.deathCountMonster += 1
        self.score += (100+(50*(level-1)))
        
        if(self.score > 1500 * self.swordValue){
            swordValue += 1
            DispatchQueue.main.async {
                self.swordView.image = self.swordImageArray[self.level-1]
            }
        }
        print("MONSTER DEATH COUNTER : \(self.deathCountMonster)")
        if(self.deathCountMonster % (5+(level*2)) == 0){            // 5+(level*2)번 죽이면 Level Up
            if(level != 6){
                self.level += 1
                DispatchQueue.main.async {
                    self.bgView.backgroundColor = UIColor(patternImage: UIImage(named: "level\(self.level)_bg.png")!)
                    self.stageLevelLable.text = "Level \(self.level)"
                }
            }
            self.deathCountMonster = 0
        }
        return;
    }
    
    
    //MARK: - 몬스터를 view에서 제거해줌(UI가 변경되므로 global -> main Queue 사용)
    func removeMonster(){
        // print("removeMonster")
        print("USER DEATH COUNTER : \(self.deathCountUser)")
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.fieldMonster[0].removeFromSuperview()                  // 가장 앞에 있는 필드 몬스터를 삭제한다.
                self.fieldMonster.remove(at: 0)                             // 필드 몬스터 배열에서도 지워준다.
                self.changeScoreText()
                self.deathCounting()
            }
        }
        
        return;
    }
    
    
    
    //MARK: - 점수 올려주는 함수
    func changeScoreText() {
        DispatchQueue.main.async {
            self.scoreBoard.text = "\(self.score)점"
            print(self.score)
        }
    }
    //MARK: - 죽은 횟수 올려주는 함수
    func deathCounting(){
        DispatchQueue.main.async {
            self.deathCountLabel.text = "\(self.deathCountUser) 번이나 죽었어?!"
        }
    }
    
    //MARK: - '게임 시작' 버튼을 눌렀을 때, 해당하는 action을 취하는 함수
    @IBAction func startBtnTapped(_ sender: UIButton) {
        // print("startBtnTapped")
        startBtn.isHidden = true
        alphaView.isHidden = true
        print(self.swordView.frame.maxY)
        DispatchQueue.main.async {
            self.bgView.backgroundColor = UIColor(patternImage: UIImage(named: "level1_bg.png")!)
            self.swordView.image = UIImage(named: "level1_sword.png")
            self.counter = 60
        }
        checkMode()
    }
    
    
    //MARK: - 공격버튼을 눌렀을때, 해당하는 action을 취하는 함수
    @IBAction func attackBtnTapped(_ sender: UIButton) {
        self.attackCount+=1
        if(self.attackCount == 10){
            usleep(20000)                                   // moveImage가 16666의 ms딜레이를 가지고 있어서 여기도 시간 걸어줘야 함
            self.attackCount = 0
        }
    }
}

