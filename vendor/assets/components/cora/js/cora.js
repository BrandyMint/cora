/**
 * Cora.js library.
 */
(function ($) {
  $.fn.cora = function(options) {
    var defaults = {
       frequency : 3000,
       saveButtonText : 'Save',
       saveButtonClass : '',
       contentWrapperClass : ''
    };

    var options = $.extend(defaults, options);

    var CoraElement = function(el) {
      $(el).attr('contenteditable', 'true');
      $(el).addClass('cora-editable');

      this.elem = el;
      this.key = $(el).data('cora-key');
      this.url = $(el).data('cora-url');
      //this.timer = null;
      $(this.elem.wrap('<div class="cora-content-wrapper ' + options.contentWrapperClass + '"></div>'));
      this.wrapper = $(this.elem).parent('.cora-content-wrapper');
      this.saveButton = null;

      // Timer initialization.
      /*this.initTimer = function() {
        if (!this.timer) {
          this.timer = window.setTimeout($.proxy(function() {
            this.save()}, this), options.frequency
          );
        }
      }*/

      // Show save button.
      this.showSaveButton = function() {
        if (!this.saveButton) {
          this.saveButton = $('<button class="cora-save-button ' + options.saveButtonClass + '">' + options.saveButtonText + '</button>');
          this.saveButton.appendTo(this.wrapper);
          console.log(this);
          this.saveButton.click({el: this}, function(e){
             e.data.el.send();
             e.data.el.saveButton.remove();
             e.data.el.saveButton = null;
          });
        }
      }

      $(this.elem).keyup({el: this}, function(e) {
        //e.data.el.initTimer();
        e.data.el.showSaveButton();
      });

      this.save = function() {
        this.timer = null;
        this.send();
      }

      this.send = function() {
        $.ajax({
          url: this.url,
          type: $(el).data('cora-method') || 'put',
          data: {key: this.key, content: $(this.elem).html().trim()}
        }).success(function(){

        });
      }
    }

    $(this).each(function() {
      var obj = new CoraElement($(this));
    });

    return this;
  }

  $(document).ready(function(){
    $('[role="cora-content"]').cora();
  });

})(jQuery);
