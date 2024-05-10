const textGame = new TextGame();

const branch_1 = new Branch("branch_1", null)
  .addEventsAsPage([
    CanvasEvent.changeBackGround("images/backgrounds/room.jpg"),
    TextBarEvent.text(null, "[방 안]"),
    DelayEvent.delay(2000),
    SoundEvent.sfx("audio/game.mp3"),
    TextBarEvent.text(null, "[게임소리]")])
    
  .addEventsAsPage([
    CanvasEvent.changeBackGround("images/backgrounds/gameover.jpg"),
    TextBarEvent.text(null, "[GAME OVER]"),
    DelayEvent.delay(2000),
    SoundEvent.sfx("audio/gameover.mp3"),
    TextBarEvent.text("...","아...또 졌네..")])

  .addEventsAsPage([
    CanvasEvent.changeBackGround("images/backgrounds/playagain.jpg"),
    DelayEvent.delay(2000),
    TextBarEvent.text(null, "[PLAY AGAIN?]"),
    TextBarEvent.branch([
      new BranchPair("YES", "branch_1_1"),
      new BranchPair("NO", "branch_1_2")
    ])
  ]);
textGame.addBranch(branch_1);


