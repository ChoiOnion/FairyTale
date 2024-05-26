const textGame = new TextGame();
console.log("TextGame instance created");

const branch_1 = new Branch("branch_1", "branch_2")
  .addEventsAsPage([
    CanvasEvent.changeBackGround("../simulator/images/backgrounds/black.png"),
    TextBarEvent.text(null, "[방 안]"),
    DelayEvent.delay(2000),
    SoundEvent.sfx("../simulator/audio/background/game.mp3"),
    TextBarEvent.text(null, "[게임소리]")
  ])
  
  .addEventsAsPage([
    CanvasEvent.changeBackGround("../simulator/images/backgrounds/gameover.jpg"),
    TextBarEvent.text(null, "[GAME OVER]"),
    DelayEvent.delay(2000),
    SoundEvent.sfx("../simulator/audio/background/gameover.mp3"),
    TextBarEvent.text("...", "아...또 졌네..")
  ])
  
  .addEventsAsPage([
    DelayEvent.delay(2000),
    TextBarEvent.text(null, "[PLAY AGAIN?]"),
    TextBarEvent.branch([
      new BranchPair("YES", "branch_1_1", () => {
        console.log("Branch 1_1 selected, updating friendship and branching");
        textGame.updateFriendship(10);
        textGame.branchProcess({ branch: "branch_1_1" }, textGame);
      }),
      new BranchPair("NO", "branch_1_2", () => {
        console.log("Branch 1_2 selected, updating friendship and branching");
        textGame.updateFriendship(-5);
        textGame.branchProcess({ branch: "branch_1_2" }, textGame);
      })
    ])
  ]);
textGame.addBranch(branch_1);

const branch_1_1 = new Branch("branch_1_1", "branch_2")
  .addEventsAsPage([
    CanvasEvent.changeBackGround("../simulator/images/backgrounds/room.jpg"),
    TextBarEvent.text("...", "다시 도전해보자!"),
    DelayEvent.delay(500)
  ])
  .addEventsAsPage([
    TextBarEvent.text("...", "어..?누구지 "),
    CanvasEvent.addImage(
      "talk",
      "../simulator/images/characters/Talk3.png",
      modelPosition.center,
      imageShowType.FadeIn
    ),
    TextBarEvent.text(null, "[채팅창 화면]"),
    TextBarEvent.text("...", "Hi!"),
    DelayEvent.delay(5000)
  ]);
textGame.addBranch(branch_1_1);

const branch_1_2 = new Branch("branch_1_2", "branch_2")
  .addEventsAsPage([
    CanvasEvent.changeBackGround("../simulator/images/backgrounds/room.jpg"),
    TextBarEvent.text("...", "그만할래.")
  ]);
textGame.addBranch(branch_1_2);

const branch_2 = new Branch("branch_2", null)
  .addEventsAsPage([
    CanvasEvent.changeBackGround("../simulator/images/backgrounds/room.jpg"),
    TextBarEvent.text("...", "branch_2입니다.")
  ]);
textGame.addBranch(branch_2);

// 시작 브랜치를 설정
textGame.start(textGame._branchManager.getBranch('branch_1'));
console.log("Game started from branch_1");
