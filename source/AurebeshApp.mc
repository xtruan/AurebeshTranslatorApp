using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Attention as Attn;

class AurebeshApp extends App.AppBase {
    
    hidden var currentPos;
    hidden var currentMode;
    hidden var isNotesMode;

    function initialize() {
        AppBase.initialize();
        
        currentPos = AurebeshConstants.letMin;
        currentMode = AurebeshConstants.str_letters;
        isNotesMode = false;
    }

    //! onStart() is called on application start up
    function onStart(state) {
    }

    //! onStop() is called when your application is exiting
    function onStop(state) {
    }
    
    function vibeForCurrentMorse() {
        if (Attn has :VibeProfile) {
            if (getIsNotesMode()) {
                return;
            } else {
                var aurebeshStr = getCurrentMorseString();
                var vibe = {};
                for (var i=0; i<aurebeshStr.length(); i++) {
                    var char = aurebeshStr.substring(i, i+1);
                    if (char.equals(AurebeshConstants.DOT)) {
                        vibe.put(i, new Attn.VibeProfile( 75, 150 ));
                    } else if (char.equals(AurebeshConstants.DASH)) {
                        vibe.put(i, new Attn.VibeProfile( 75, 450 ));
                    } else if (char.equals(AurebeshConstants.SPACE)) {
                        vibe.put(i, new Attn.VibeProfile( 0, 150 ));
                    } else if (char.equals(AurebeshConstants.SPLIT)) {
                        vibe.put(i, new Attn.VibeProfile( 0, 450 ));
                    }
                }
                // length above 8 causes crash :(
                if (vibe.values().size() <= 8) {
                    Attn.vibrate(vibe.values());
                }
            }
        } else {
            System.println("Device does not support VibeProfile");
        }
    }
    
    function getCurrentMorseString() {
        return getMorseAtPosition(getCurrentPosition());
    }
    
    function getCurrentAsciiString() {
        if (getIsNotesMode()) {
            return getNotesString();
        } else {
            return getAsciiAtPosition(getCurrentPosition());
        }
    }
    
    function getNotesString() {
        return AurebeshConstants.notes;
    }
    
    function setCurrentMode(newMode) {
        currentMode = newMode;
        // debug - print current category
        //Sys.println(getCurrentMode());
    }
    
    hidden function getCurrentMode() {
        return currentMode;
    }
    
    function prepareNextAurebeshItem() {
        var pos = getCurrentPosition();
        pos++;
        setCurrentPosition(pos);
        prepareAurebeshItem();
    }
    
    function preparePrevAurebeshItem() {
        var pos = getCurrentPosition();
        pos--;
        setCurrentPosition(pos);
        prepareAurebeshItem();
    }
    
    function prepareMenuChangedAurebeshItem() {
        setCurrentPosition(999); // invalidate current position
        prepareAurebeshItem();
    }
    
    hidden function prepareAurebeshItem() {
        setNotesMode(false);
        if (getCurrentMode() == AurebeshConstants.str_letters) {
            if (getCurrentPosition() > getLetterMaxPosition()) {
                setCurrentPosition(getLetterMinPosition());
            } else if (getCurrentPosition() < getLetterMinPosition()) {
                setCurrentPosition(getLetterMaxPosition());
            }
        } else if (getCurrentMode() == AurebeshConstants.str_numbers) {
            if (getCurrentPosition() > getNumberMaxPosition()) {
                setCurrentPosition(getNumberMinPosition());
            } else if (getCurrentPosition() < getNumberMinPosition()) {
                setCurrentPosition(getNumberMaxPosition());
            }
        }
        // debug - print currently displayed item
        //Sys.println(getCurrentAsciiString());
    }
    
    hidden function setCurrentPosition(newPos) {
        currentPos = newPos;
    }
    
    hidden function getCurrentPosition() {
        return currentPos;
    }
    
    hidden function setNotesMode(notesMode) {
        isNotesMode = notesMode;
    }
    
    function getIsNotesMode() {
        return isNotesMode;
    }
    
    hidden function getAsciiAtPosition(pos) {
        return AurebeshConstants.asciiArray[pos];
    }
    
    hidden function getMorseAtPosition(pos) {
        return AurebeshConstants.aurebeshArray[pos];
    }
    
    hidden function getNumberMinPosition() {
        return AurebeshConstants.numMin;
    }
    
    hidden function getNumberMaxPosition() {
        return AurebeshConstants.numMax;
    }
    
    hidden function getLetterMinPosition() {
        return AurebeshConstants.letMin;
    }
    
    hidden function getLetterMaxPosition() {
        return AurebeshConstants.letMax;
    }
    
    hidden function getSymbolMinPosition() {
        return AurebeshConstants.symMin;
    }
    
    hidden function getSymbolMaxPosition() {
        return AurebeshConstants.symMax;
    }
    
    hidden function getProsignMinPosition() {
        return AurebeshConstants.proMin;
    }
    
    hidden function getProsignMaxPosition() {
        return AurebeshConstants.proMax;
    }
    
    hidden function getPhraseMinPosition() {
        return AurebeshConstants.phsMin;
    }
    
    hidden function getPhraseMaxPosition() {
        return AurebeshConstants.phsMax;
    }
    
    hidden function getQCodeMinPosition() {
        return AurebeshConstants.qcdMin;
    }
    
    hidden function getQCodeMaxPosition() {
        return AurebeshConstants.qcdMax;
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new AurebeshView(), new AurebeshDelegate() ];
    }

}
