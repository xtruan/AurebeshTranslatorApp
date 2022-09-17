using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AurebeshView extends Ui.View {

    hidden var firstUpdate = true;
    hidden var aurebeshFont;

    function initialize() {
        View.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        aurebeshFont = Ui.loadResource(Rez.Fonts.AurebeshFont);
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        var h = dc.getHeight();
        var w = dc.getWidth();
        
        // Set the background color then call to clear the screen
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
    
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        if (App.getApp().getIsNotesMode()) {
            var notes = App.getApp().getNotesString();
            dc.drawText(w/2, h/2, Gfx.FONT_XTINY, notes, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
        } else {
            var aurebesh = App.getApp().getCurrentAsciiString();
            var seperatorPos = aurebesh.find(AurebeshConstants.SPLIT);
            if (seperatorPos != null) {
                var aurebeshText = aurebesh.substring(0, seperatorPos); // + "\n" + 
                    //aurebesh.substring(seperatorPos+1, aurebesh.length());
                dc.drawText(w/2, (h/2)-20, aurebeshFont, aurebeshText, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
            } else {
                dc.drawText(w/2, (h/2)-20, aurebeshFont, aurebesh, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
            }
            
            var ascii = App.getApp().getCurrentAsciiString();
            seperatorPos = ascii.find(AurebeshConstants.SPLIT);
            if (seperatorPos != null) {
                dc.drawText(w/2, h/20, Gfx.FONT_LARGE, ascii.substring(0, seperatorPos), Gfx.TEXT_JUSTIFY_CENTER);
                dc.drawText(w/2, 15*h/20, Gfx.FONT_TINY, ascii.substring(seperatorPos+1, ascii.length()), Gfx.TEXT_JUSTIFY_CENTER);
            } else {
                dc.drawText(w/2, h/20, Gfx.FONT_LARGE, ascii, Gfx.TEXT_JUSTIFY_CENTER);
            }
        }
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}
