using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class AurebeshDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        // menu
        Ui.pushView(new Rez.Menus.MainMenu(), new AurebeshMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
    
    function onHold(tap) {
        // do vibe
        App.getApp().vibeForCurrentMorse();
        return true;
    }
    
    function onSwipe(swipe) {
        if (swipe.getDirection() == Ui.SWIPE_LEFT) {
            // next
            App.getApp().prepareNextAurebeshItem();
            Ui.requestUpdate();
        } else if (swipe.getDirection() == Ui.SWIPE_RIGHT) {
            // prev
            App.getApp().preparePrevAurebeshItem();
            Ui.requestUpdate();
        }
        return true;
    }
    
    function onKey(key) {
        //System.println(key.getKey());
        if (key.getKey() == Ui.KEY_ENTER) {
            // do vibe
            App.getApp().vibeForCurrentMorse();
        } else if (key.getKey() == Ui.KEY_UP) {
            // prev
            App.getApp().preparePrevAurebeshItem();
            Ui.requestUpdate();
        } else if (key.getKey() == Ui.KEY_DOWN) {
            // next
            App.getApp().prepareNextAurebeshItem();
            Ui.requestUpdate();
        }
        return true;
    }
}