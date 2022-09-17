using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class AurebeshMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :menu_letters) {
            App.getApp().setCurrentMode(AurebeshConstants.str_letters);
        } else if (item == :menu_numbers) {
            App.getApp().setCurrentMode(AurebeshConstants.str_numbers);
        } else if (item == :menu_symbols) {
            App.getApp().setCurrentMode(AurebeshConstants.str_symbols);
        }
        App.getApp().prepareMenuChangedAurebeshItem();
    }
}