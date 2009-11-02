// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.fn.extend({
  disable: function() {
    return $(this).each(function() { $(this).attr('disabled', 'disabled'); });
  },
  enable: function() {
    return $(this).each(function() { $(this).removeAttr('disabled'); });
  },
  toggleDisabled: function() {
    return this.each(function() {
      if ($(this).attr('disabled') == true) {
        $(this).enable();
      } else {
        $(this).disable();
      }
    });
  }
});
