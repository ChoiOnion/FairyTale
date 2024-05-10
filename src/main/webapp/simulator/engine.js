class TextGame {
    constructor() {
        this._textBarController = new TextBarController(this.branchProcess);
        this._canvasController = new CanvasController();
        this._soundController = new SoundController();
        this._branchManager = new BranchManager();
        this._currentBranch = new Branch("Root", "END");
        this._currentPageIndex = 0;
        this._delaytimer = null;
        this._isBranching = false;
    }
    
    get textBarController() { return this._textBarController; }
    get canvasController() { return this._canvasController; }

    addBranch(branch) {
        this._branchManager.addBranch(branch);
    }

    setTextBarElement(chatBox, nameBox) {
        this._textBarController.init(chatBox, nameBox);
    }

    setCanvasElement(canvasImg, leftImg, centerImg, rightImg) {
        this._canvasController.init(canvasImg, leftImg, centerImg, rightImg);
    }

    start(entryBranch) {
        this._currentBranch = entryBranch;
        this.nextPage();
    }

    nextPage() {
        if (this._currentBranch.pages.length <= this._currentPageIndex)
            return;

        if (this._isBranching === true)
            return;
            
        if (this._currentPageIndex != 0)

        if (this._delaytimer !== null) {
            if (this._currentPageIndex != 0) {
                if (this._currentBranch.pages[this._currentPageIndex - 1].baseEvents.find(b => {
                    return b.eventType === EventType.TextBar && b.textBarEventType === TextbarEventType.Branch
                }) != undefined)
                    return;
    
                if (this._currentBranch.pages[this._currentPageIndex - 1].baseEvents.find(b => {
                    return b.eventType === EventType.Canvas && b.canvasEventType === CanvasEventType.ChangeBackGround
                }) != undefined)
                    return;
    
                if (this._currentBranch.pages[this._currentPageIndex - 1].baseEvents.find(b => {
                    return b.eventType === EventType.Canvas && b.canvasEventType === CanvasEventType.RemoveObject
                }) != undefined)
                    return;
    
                if (this._currentBranch.pages[this._currentPageIndex - 1].baseEvents.find(b => {
                    return b.eventType === EventType.Sound
                }) != undefined)
                    return;
            }
            
            clearTimeout(this._delaytimer);
            this._delaytimer = null;
        }
        
        const currentPage = this._currentBranch.pages[this._currentPageIndex];
        const currentEvents = currentPage.baseEvents;
        
        this.eventProcess(currentEvents);

        if (this._currentBranch.pages.length <= this._currentPageIndex + 1) {
            const jumpBranch = this._branchManager.getBranch(this._currentBranch.end);
            if (jumpBranch !== null) {
                this._currentBranch = jumpBranch;
                this._currentPageIndex = -1;
            }
        }
        this._currentPageIndex += 1;   
    }

    eventProcess(baseEvent){
        for (let index = 0; index < baseEvent.length; index++) {
            const item = baseEvent[index];
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
        switch (textBarEvent.textBarEventType) {
            case TextbarEventType.Text:
                this._textBarController.setText(textBarEvent.eventData.name, textBarEvent.eventData.text);
                break;

            case TextbarEventType.Branch:
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
        switch (canvasEvent.canvasEventType) {
            case CanvasEventType.AddImage:
                this._canvasController.imageShow(
                    canvasEvent._eventData.name, 
                    canvasEvent._eventData.src, 
                    canvasEvent._eventData.positon, 
                    canvasEvent._eventData.transition
                );
                break;

            case CanvasEventType.ChangeBackGround:
                this._canvasController.setBackground(
                    canvasEvent._eventData.src
                );
                break;

            case CanvasEventType.DrawText:
                this._canvasController.drawtext(
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
        switch (soundEvent.soundEventType) {
            case SoundEventType.Background:
                if (soundEvent.stop === true)
                    this._soundController.stopBackground();
                else
                    this._soundController.playBackground(soundEvent.src);
                break;
                
            case SoundEventType.Sfx:
                this._soundController.playSound(soundEvent.src)
                break;
        
            default:
                break;
        }
    }
    
    delayProcess(delayEvent, baseEvents, index) {
        this._delaytimer = setTimeout(() => {
            for (let innerIndex = index + 1; innerIndex < baseEvents.length; innerIndex++) {
                const item = baseEvents[innerIndex];
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
        }, delayEvent.delay);
    }


    branchProcess(branchPair, o) {
        const jumpBranch = o._branchManager.getBranch(branchPair.branch);
        if (jumpBranch == null) {
            o._canvasController.endScreen("END (Error)");
            o._isBranching = false;
            return;
        } else {
            o._currentBranch = jumpBranch;
            o._currentPageIndex = 0;
        }
        o._isBranching = false;
    }
}

const EventType = {
	TextBar: 0,
    Canvas: 1,
    Sound: 2,
    Delay: 3
}

const TextbarEventType = {
	Text: 0,
	Branch: 1
}

const CanvasEventType = {
	AddImage: 0,
    ChangeBackGround: 1,
    DrawText: 2,
    ShowEnding: 3,
    RemoveObject: 4
}

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
    addBackbroundEvent(src){
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
    constructor(name, branch) {
        this._name = name;
        this._branch = branch;
    }   

    get name() { return this._name; }
    get branch() { return this._branch; }
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
    constructor(name, src, positon, transition) {
        this._name = name;
        this._src = src;
        this._positon = positon;
        this._transition = transition;
    }

    get name() { return this._name; }
    get src() { return this._src; }
    get positon() { return this._positon; }
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
}

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

    static stopbackground() {
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
    }

    setText(name, text) { 
        if(name == null) {
            this._nameBox.style.visibility = "hidden";
            this._nameBox.innerHTML = "";
        } else{
            this._nameBox.style.visibility = "visible";
            this._nameBox.innerHTML = name;
        }
        this._chatBox.innerHTML = text + "<br>";
    }

    showBranch(options, o) { 
        let button = [];
        let label = [];
        let text = [];
        for(let i = 0; i < options.length; i++){
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
                    resolve(options[i]);
                    tmpThis.clearTextBar();
                }, false);
            })
        }
    }

    clearTextBar() {
        while(this._chatBox.hasChildNodes()){
            this._chatBox.removeChild(this._chatBox.firstChild);
        }
        this._nameBox.style.visibility = "hidden";
        this._nameBox.innerHTML = "";
    }
}

const imageShowType = {
	Appear: 0,
    FadeIn: 1
}

const imageHideType = {
	Disappear: 0,
    FadeOut: 1
}

const modelPosition = {
    left: 0,
    center: 1,
    right: 2
}

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
        for(let i = 0; i < 3; i++){
            img[i].style.opacity = 0;
        }
    }

    imageShow(name, src, position, transition) { 
        let img;
        if(position === 0) {
            img = this._leftImg;
        }
        else if(position === 1) {
            img = this._centerImg;
        }
        else if(position === 2) {
            img = this._rightImg;
        }
        img.src = src;
        img.className = name;
        img.style.width = "40vw";
        if(transition === 1){
            
            img.style.transition = '2s';
            img.style.opacity = '1';
        }
        else{
            img.style.transition = 'all 0s';
            img.style.opacity = '1';
        }

    }
    
    imageRemove(name, transition) { 
	
        const img = document.getElementById('canvasDiv').getElementsByClassName(name)[0];
        if(img === undefined) return;
        img.className = "";
        if(transition === 1) {
            img.style.transition = '2s';
            img.style.opacity = '0';
            setTimeout(() => {
                img.src = "";
            }, 2000);
        }
        else{
            img.style.transition = '0s';
            img.style.opacity = '0';
            setTimeout(() => {
                img.src = "";
            }, 1000);
        }
    }

    setBackground(src) {
        this._canvasImg.style.opacity = "0";
        setTimeout(() => {
            this._canvasImg.src = src;
        }, 1000);
        setTimeout(() => {
            this._canvasImg.style.opacity = "1";
        }, 2000);
    }

    drawtext(text){ 
        if(text === null){
            this._chatBox.innerHTML = "";
            return;
        }
        this._chatBox.innerHTML = text;
    }

    endScreen(text) {
        const canvasDiv = document.getElementById('canvasDiv');
        while(canvasDiv.firstChild){
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

    addBackbroundPage(src){
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
        this._backgroundSound.src = src;
        this._backgroundSound.play();
    }

    stopBackground() {
        this._backgroundSound.pause();
        this._backgroundSound.src = "";
    }

    //src: String
    playSound(src) {
        this._activeSound.src = src;
        this._activeSound.play();
    }
}