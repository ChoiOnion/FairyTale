document.addEventListener('DOMContentLoaded', (event) => {
    console.log("DOM fully loaded and parsed");

    textGame.setTextBarElement(document.getElementById('chatBox'), document.getElementById('nameBox'));
    textGame.setCanvasElement(document.getElementById('backgroundImg'), document.getElementById('leftImg'), document.getElementById('centerImg'), document.getElementById('rightImg'));

    console.log("TextBar and Canvas elements are set");

    textGame.loadProgress(); 

    console.log("Game started with saved progress");
});
