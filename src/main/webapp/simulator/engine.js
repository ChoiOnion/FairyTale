class TextGame {
    constructor() {
        this._textBarController = new TextBarController(this.branchProcess.bind(this));
        this._canvasController = new CanvasController();
        this._soundController = new SoundController();
        this._branchManager = new BranchManager();
        this._currentBranch = new Branch("Root", "END");
        this._currentPageIndex = 0;
        this._delaytimer = null;
        this._isBranching = false;
        this._friendship = 50; // 기본 호감도 설정
        console.log("TextGame initialized"); // 디버깅 로그
    }

    get textBarController() { return this._textBarController; }
    get canvasController() { return this._canvasController; }
    get friendship() { return this._friendship; }

    addBranch(branch) {
        console.log(`Adding branch: ${branch.branchName}`);
        this._branchManager.addBranch(branch);
    }

    setTextBarElement(chatBox, nameBox) {
        this._textBarController.init(chatBox, nameBox);
    }

    setCanvasElement(canvasImg, leftImg, centerImg, rightImg) {
        this._canvasController.init(canvasImg, leftImg, centerImg, rightImg);
    }

    start(entryBranch) {
        if (!entryBranch) {
            console.error("Entry branch is undefined");
            return;
        }
        console.log(`Starting branch: ${entryBranch.branchName}`);
        this._currentBranch = entryBranch;
        this._currentPageIndex = 0;
        this.nextPage();
    }

    startFromCurrentPage() {
        console.log(`Starting from branch: ${this._currentBranch.branchName}, page: ${this._currentPageIndex}`);
        this.nextPage();
    }

    nextPage() {
        console.log("nextPage called");
        if (this._currentBranch.pages.length <= this._currentPageIndex) {
            console.log("No more pages in current branch");
            return;
        }

        if (this._isBranching === true) {
            console.log("Currently branching, returning");
            return;
        }

        if (this._delaytimer !== null) {
            console.log("Delay timer is still active, returning");
            return;
        }

        const currentPage = this._currentBranch.pages[this._currentPageIndex];
        const currentEvents = currentPage.baseEvents;

        console.log("Processing events for page index", this._currentPageIndex);
        this.eventProcess(currentEvents);

        this._currentPageIndex += 1;

        if (this._currentBranch.pages.length <= this._currentPageIndex) {
            const jumpBranch = this._branchManager.getBranch(this._currentBranch.end);
            if (jumpBranch !== null) {
                console.log(`Jumping to branch: ${jumpBranch.branchName}`);
                this._currentBranch = jumpBranch;
                this._currentPageIndex = 0;
            } else {
                this._currentPageIndex = this._currentBranch.pages.length - 1; // Set to the last page
            }
        }
        console.log("Page index incremented to", this._currentPageIndex);

        // Save progress after transitioning to the next page
        this.saveProgress(this._currentBranch.branchName, this._currentPageIndex, this._friendship);
    }

    eventProcess(baseEvent) {
        console.log("eventProcess called with events", baseEvent);
        for (let index = 0; index < baseEvent.length; index++) {
            const item = baseEvent[index];
            console.log("Processing event", item);
            switch (item.eventType) {
                case EventType.TextBar:
                    this.textBarProcess(item);
                    break;

                case EventType.Canvas:
                    this.canvasProcess(item);
                    break;

                case EventType.Sound:
                    this.soundProcess(item);
                    break;

                case EventType.Delay:
                    this.delayProcess(item, baseEvent, index);
                    return;

                default:
                    break;
            }
        }
    }

    textBarProcess(textBarEvent) {
        console.log("textBarProcess called with event", textBarEvent);
        switch (textBarEvent.textBarEventType) {
            case TextbarEventType.Text:
                console.log("Setting text:", textBarEvent.eventData.name, textBarEvent.eventData.text);
                this._textBarController.setText(textBarEvent.eventData.name, textBarEvent.eventData.text);
                break;

            case TextbarEventType.Branch:
                console.log("Processing branch options");
                this._isBranching = true;
                let selectedData = [];
                textBarEvent.eventData.forEach((item) => selectedData.push(item.name));
                this._textBarController.showBranch(textBarEvent.eventData, this);
                break;

            default:
                break;
        }
    }

    canvasProcess(canvasEvent) {
        console.log("canvasProcess called with event", canvasEvent);
        switch (canvasEvent.canvasEventType) {
            case CanvasEventType.AddImage:
                this._canvasController.imageShow(
                    canvasEvent._eventData.name,
                    canvasEvent._eventData.src,
                    canvasEvent._eventData.position,
                    canvasEvent._eventData.transition
                );
                break;

            case CanvasEventType.ChangeBackGround:
                this._canvasController.setBackground(
                    canvasEvent._eventData.src
                );
                break;

            case CanvasEventType.DrawText:
                this._canvasController.drawText(
                    canvasEvent._eventData.text
                );
                break;

            case CanvasEventType.ShowEnding:
                this._canvasController.endScreen(
                    canvasEvent._eventData.text
                );
                break;

            case CanvasEventType.RemoveObject:
                this._canvasController.imageRemove(
                    canvasEvent._eventData.name,
                    canvasEvent._eventData.transition
                );
                break;

            default:
                break;
        }
    }

    soundProcess(soundEvent) {
        console.log("soundProcess called with event", soundEvent);
        switch (soundEvent.soundEventType) {
            case SoundEventType.Background:
                if (soundEvent.stop === true)
                    this._soundController.stopBackground();
                else
                    this._soundController.playBackground(soundEvent.src);
                break;

            case SoundEventType.Sfx:
                this._soundController.playSound(soundEvent.src);
                break;

            default:
                break;
        }
    }

    delayProcess(delayEvent, baseEvents, index) {
        console.log("delayProcess called with delay", delayEvent.delay);
        this._delaytimer = setTimeout(() => {
            console.log("Delay complete, processing remaining events");
            for (let innerIndex = index + 1; innerIndex < baseEvents.length; innerIndex++) {
                const item = baseEvents[innerIndex];
                console.log("Processing event after delay", item);
                switch (item.eventType) {
                    case EventType.TextBar:
                        this.textBarProcess(item);
                        break;

                    case EventType.Canvas:
                        this.canvasProcess(item);
                        break;

                    case EventType.Sound:
                        this.soundProcess(item);
                        break;

                    case EventType.Delay:
                        this.delayProcess(item, baseEvents, innerIndex);
                        return;

                    default:
                        break;
                }
            }
            this._delaytimer = null;
            this.nextPage();  // Delay가 끝나면 다음 페이지로 이동
        }, delayEvent.delay);
    }

    branchProcess(branchPair, o) {
        console.log("branchProcess called with branchPair", branchPair);
        const jumpBranch = o._branchManager.getBranch(branchPair.branch);
        if (jumpBranch == null) {
            o._canvasController.endScreen("END (Error)");
            o._isBranching = false;
            return;
        } else {
            o._currentBranch = jumpBranch;
            o._currentPageIndex = 0;
            o.nextPage(); // 분기 후 페이지 처리
        }
        o._isBranching = false;
    }

    // 호감도 업데이트 함수
    updateFriendship(amount) {
        this._friendship += amount;
        console.log(`Friendship updated by ${amount}. New friendship level: ${this._friendship}`);
        this.saveProgress(this._currentBranch.branchName, this._currentPageIndex, this._friendship);
    }

    // 진행 상황 저장 함수
    saveProgress(branch, pageIndex, friendship) {
        if (branch == null || friendship == null || pageIndex == null) {
            console.error("Branch, pageIndex, or friendship is null. Cannot save progress.");
            return;
        }

        const data = new URLSearchParams({
            story_progress: branch,
            story_friendship: friendship.toString(), // Ensure friendship is a string
            story_page_index: pageIndex.toString() // Save the current page index
        });

        console.log("Sending data:", data.toString()); // Debug log

        fetch('saveProgress.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data.toString()
        }).then(response => {
            console.log("Response status:", response.status); // Debug log
            return response.text();
        }).then(data => console.log("Response data:", data))
        .catch(error => console.error('Error:', error));
    }

    // 저장된 데이터로 게임을 초기화하는 함수
    loadProgress() {
        fetch('loadProgress.jsp', {
            method: 'GET',
        }).then(response => response.json())
        .then(data => {
            console.log("Loaded data:", data);
            if (data && data.story_progress && data.story_friendship !== undefined) {
                this._currentBranch = this._branchManager.getBranch(data.story_progress);
                this._friendship = parseInt(data.story_friendship, 10);

                // Ensure the current branch and page index are valid before starting
                if (this._currentBranch) {
                    // Increment the page index
                    this._currentPageIndex = (parseInt(data.story_page_index, 10) || 0) + 1;

                    // Check if the new page index exceeds the number of pages in the branch
                    if (this._currentPageIndex >= this._currentBranch.pages.length) {
                        // If so, move to the next branch if it exists
                        const nextBranch = this._branchManager.getBranch(this._currentBranch.end);
                        if (nextBranch) {
                            this._currentBranch = nextBranch;
                            this._currentPageIndex = 0;
                        } else {
                            this._currentPageIndex = this._currentBranch.pages.length - 1; // Set to the last page
                        }
                    }
                } else {
                    console.error("Current branch not found:", data.story_progress);
                }

                this.startFromCurrentPage();
            } else {
                console.log("No saved data found, starting from default branch");
                this.start(this._branchManager.getBranch('branch_1')); // Default starting branch
            }
        }).catch(error => {
            console.error('Error:', error);
            console.log("No saved data found, starting from default branch");
            this.start(this._branchManager.getBranch('branch_1')); // Default starting branch
        });
    }

    // 현재 호감도를 반환하는 함수
    getCurrentFriendship() {
        return this._friendship;
    }
}

// EventType: Number
const EventType = {
    TextBar: 0,
    Canvas: 1,
    Sound: 2,
    Delay: 3
};

// TextbarEventType: Number
const TextbarEventType = {
    Text: 0,
    Branch: 1
};

// CanvasEventType: Number
const CanvasEventType = {
    AddImage: 0,
    ChangeBackGround: 1,
    DrawText: 2,
    ShowEnding: 3,
    RemoveObject: 4
};

class Page {
    constructor() {
        this._baseEvents = [];
    }

    addEvent(baseEvent) {
        this._baseEvents.push(baseEvent);
        return this;
    }

    addTextEvent(name, text) {
        this.addEvent(TextBarEvent.text(name, text));
        return this;
    }

    addBackgroundEvent(src) {
        this.addEvent(CanvasEvent.changeBackGround(src));
        return this;
    }

    removeEvent(baseEvent) {
        this._baseEvents.push(baseEvent);
        return this;
    }

    get baseEvents() { return this._baseEvents; }
}

class BaseEvent {
    constructor(eventType) {
        this._eventType = eventType;
    }

    get eventType() { return this._eventType; }
}

class TextBarEvent extends BaseEvent {
    constructor(textBarEventType, eventData) {
        super(EventType.TextBar);
        this._textBarEventType = textBarEventType;
        this._eventData = eventData;
    }

    static text(name, text) {
        return new TextBarEvent(TextbarEventType.Text, new TextPair(name, text));
    }

    static branch(branchPairs) {
        return new TextBarEvent(TextbarEventType.Branch, branchPairs);
    }

    get textBarEventType() { return this._textBarEventType; }
    get eventData() { return this._eventData; }
}

class TextPair {
    constructor(name, text) {
        this._name = name;
        this._text = text;
    }

    get name() { return this._name; }
    get text() { return this._text; }
}

class BranchPair {
    constructor(name, branch, callback) {
        this._name = name;
        this._branch = branch;
        this._callback = callback;
    }

    get name() { return this._name; }
    get branch() { return this._branch; }
    get callback() { return this._callback; }
}

class CanvasEvent extends BaseEvent {
    constructor(canvasEventType, eventData) {
        super(EventType.Canvas);
        this._canvasEventType = canvasEventType;
        this._eventData = eventData;
    }

    static addImage(name, src, position, transition) {
        return new CanvasEvent(
            CanvasEventType.AddImage,
            new ImagePair(name, src, position, transition)
        );
    }

    static changeBackGround(src) {
        return new CanvasEvent(
            CanvasEventType.ChangeBackGround,
            new BackGroundPair(src)
        );
    }

    static drawText(text) {
        return new CanvasEvent(
            CanvasEventType.DrawText,
            new DrawTextPair(text)
        );
    }

    static showEnding(text) {
        return new CanvasEvent(
            CanvasEventType.ShowEnding,
            new DrawTextPair(text)
        );
    }

    static removeObject(name, transition) {
        return new CanvasEvent(
            CanvasEventType.RemoveObject,
            new RemoveObjectPair(name, transition)
        );
    }

    get canvasEventType() { return this._canvasEventType; }
    get eventData() { return this._eventData; }
}

class ImagePair {
    constructor(name, src, position, transition) {
        this._name = name;
        this._src = src;
        this._position = position;
        this._transition = transition;
    }

    get name() { return this._name; }
    get src() { return this._src; }
    get position() { return this._position; }
    get transition() { return this._transition; }
}

class BackGroundPair {
    constructor(src) {
        this._src = src;
    }

    get src() { return this._src; }
}

class DrawTextPair {
    constructor(text) {
        this._text = text;
    }

    get text() { return this._text; }
}

class RemoveObjectPair {
    constructor(name, transition) {
        this._name = name;
        this._transition = transition;
    }

    get name() { return this._name; }
    get transition() { return this._transition; }
}

const SoundEventType = {
    Background: 0,
    Sfx: 1
};

class SoundEvent extends BaseEvent {
    constructor(src, soundEventType, stop) {
        super(EventType.Sound);
        this._src = src;
        this._soundEventType = soundEventType;
        this._stop = stop;
    }

    static background(src) {
        return new SoundEvent(src, SoundEventType.Background, false);
    }

    static stopBackground() {
        return new SoundEvent(null, SoundEventType.Background, true);
    }

    static sfx(src) {
        return new SoundEvent(src, SoundEventType.Sfx, false);
    }

    get src() { return this._src; }
    get soundEventType() { return this._soundEventType; }
    get stop() { return this._stop; }
}

class DelayEvent extends BaseEvent {
    constructor(delay) {
        super(EventType.Delay);
        this._delay = delay;
    }

    static delay(delay) {
        return new DelayEvent(delay);
    }

    get delay() { return this._delay; }
}

class TextBarController {
    constructor(callback) {
        this._chatBox = null;
        this._nameBox = null;
        this._callback = callback;
    }

    init(chatBox, nameBox) {
        this._chatBox = chatBox;
        this._nameBox = nameBox;
        console.log("TextBarController initialized with chatBox and nameBox");
    }

    setText(name, text) {
        console.log("setText called with name:", name, "text:", text);
        if (this._nameBox && this._chatBox) {
            if (name == null) {
                this._nameBox.style.visibility = "hidden";
                this._nameBox.innerHTML = "";
            } else {
                this._nameBox.style.visibility = "visible";
                this._nameBox.innerHTML = name;
            }
            this._chatBox.innerHTML = text + "<br>";
        } else {
            console.error("ChatBox or NameBox is not initialized");
        }
    }
    
    showBranch(options, o) {
        let button = [];
        let label = [];
        let text = [];
        for (let i = 0; i < options.length; i++) {
            label[i] = document.createElement('label');
            button[i] = document.createElement('button');
            text[i] = document.createElement('span');
            this._chatBox.appendChild(label[i]);
            label[i].appendChild(button[i]);
            label[i].appendChild(text[i]);
            label[i].appendChild(document.createElement('br'));
            text[i].innerHTML = "→" + options[i].name;

            eventlistener(i).then((resolvedData) => {
                this._callback(resolvedData, o);
            });
        }
        const tmpThis = this;

        function eventlistener(i) {
            return new Promise(function(resolve, reject) {
                button[i].addEventListener('click', function(event) {
                    options[i].callback();
                    resolve(options[i]);
                    tmpThis.clearTextBar();
                }, false);
            });
        }
    }

    clearTextBar() {
        while (this._chatBox.hasChildNodes()) {
            this._chatBox.removeChild(this._chatBox.firstChild);
        }
        this._nameBox.style.visibility = "hidden";
        this._nameBox.innerHTML = "";
    }
}


const imageShowType = {
    Appear: 0,
    FadeIn: 1
};

const imageHideType = {
    Disappear: 0,
    FadeOut: 1
};

const modelPosition = {
    left: 0,
    center: 1,
    right: 2
};

class CanvasController {
    constructor() {
        this._canvasImg = null;
        this._leftImg = null;
        this._centerImg = null;
        this._rightImg = null;
    }

    init(canvasImg, leftImg, centerImg, rightImg) {
        this._canvasImg = canvasImg;
        this._canvasImg.style.opacity = "0";
        this._canvasImg.style.transitionDuration = "1s";
        this._leftImg = leftImg;
        this._centerImg = centerImg;
        this._rightImg = rightImg;
        const img = document.getElementById('canvasDiv').getElementsByClassName('img');
        for (let i = 0; i < 3; i++) {
            img[i].style.opacity = 0;
        }
    }

    imageShow(name, src, position, transition) {
        console.log(`imageShow called with name: ${name}, src: ${src}, position: ${position}, transition: ${transition}`);
        let img;
        if (position === 0) {
            img = this._leftImg;
        } else if (position === 1) {
            img = this._centerImg;
        } else if (position === 2) {
            img = this._rightImg;
        }
        img.src = src;
        img.className = name;
        img.style.width = "40vw";
        if (transition === 1) {
            img.style.transition = '2s';
            img.style.opacity = '1';
        } else {
            img.style.transition = 'all 0s';
            img.style.opacity = '1';
        }
    }

    imageRemove(name, transition) {
        console.log(`imageRemove called with name: ${name}, transition: ${transition}`);
        const img = document.getElementById('canvasDiv').getElementsByClassName(name)[0];
        if (img === undefined) return;
        img.className = "";
        if (transition === 1) {
            img.style.transition = '2s';
            img.style.opacity = '0';
            setTimeout(() => {
                img.src = "";
            }, 2000);
        } else {
            img.style.transition = '0s';
            img.style.opacity = '0';
            setTimeout(() => {
                img.src = "";
            }, 1000);
        }
    }

    setBackground(src) {
        console.log(`setBackground called with src: ${src}`);
        this._canvasImg.style.opacity = "0";
        setTimeout(() => {
            this._canvasImg.src = src;
        }, 1000);
        setTimeout(() => {
            this._canvasImg.style.opacity = "1";
        }, 2000);
    }

    drawText(text) {
        if (text === null) {
            this._chatBox.innerHTML = "";
            return;
        }
        this._chatBox.innerHTML = text;
    }

    endScreen(text) {
        const canvasDiv = document.getElementById('canvasDiv');
        while (canvasDiv.firstChild) {
            canvasDiv.removeChild(canvasDiv.firstChild);
        }

        canvasDiv.style.backgroundColor = "black";
        canvasDiv.classList.add("endScreen");
        canvasDiv.innerHTML = text;
        canvasDiv.style.color = "white";
        canvasDiv.style.paddingTop = "27vw";

        setTimeout(() => {
            location.href = "main.html";
        }, 5000);
    }
}

class BranchManager {
    constructor() {
        this._branches = [];
    }

    addBranch(branch) {
        this._branches.push(branch);
    }

    getBranch(branchName) {
        const find = this._branches.find(branch => branch.branchName === branchName);
        if (find === undefined)
            return null;
        else
            return find;
    }
}

class Branch {
    constructor(branchName, end) {
        this._branchName = branchName;
        this._end = end;
        this._pages = [];
    }

    addPage(page) {
        this._pages.push(page);
        return this;
    }

    addTextPage(name, text) {
        this.addPage(new Page().addEvent(TextBarEvent.text(name, text)));
        return this;
    }

    addBackgroundPage(src) {
        this.addPage(new Page().addEvent(CanvasEvent.changeBackGround(src)));
        return this;
    }

    addEventsAsPage(baseEvents) {
        const page = new Page();
        baseEvents.forEach(element => {
            page.addEvent(element);
        });
        this.addPage(page);
        return this;
    }

    addEndingAsPage(text) {
        this.addPage(new Page().addEvent(CanvasEvent.showEnding(text)));
        return this;
    }

    removePage() {
        return this._pages.pop();
    }

    getNextBranch(branchManager) {
        return branchManager.getBranch(this._end);
    }

    get branchName() { return this._branchName; }
    get end() { return this._end; }
    get pages() { return this._pages; }
}


class SoundController {
    constructor() {
        this._backgroundSound = new Audio();
        this._activeSound = new Audio();
        this._backgroundSound.volume = 0.2;
        this._activeSound.volume = 0.2;
    }

    playBackground(src) {
        console.log(`Playing background sound: ${src}`);
        this._backgroundSound.src = src;
        this._backgroundSound.play();
    }

    stopBackground() {
        console.log("Stopping background sound");
        this._backgroundSound.pause();
        this._backgroundSound.src = "";
    }

    playSound(src) {
        console.log(`Playing sound effect: ${src}`);
        this._activeSound.src = src;
        this._activeSound.play();
    }
}
