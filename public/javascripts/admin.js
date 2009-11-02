$(document).ready(function() {
  if ($('#top_info').html() != '') {
    $('#top_info').fadeIn("slow");
  }
  
  $('table.list tr')
    .live('mouseover', function(e) {    
      $(this).addClass('hover')
    })
    .live('mouseout', function(e) {
      $(this).removeClass('hover')
    });

  $('input._tree').change(function(e) {
    var id = $(this).attr('rel');
    var child_class = '._parent_' + id;
    $(this).attr('checked') ? $(child_class).disable().attr('checked', true) : $(child_class).enable().attr('checked', false);
  });
});

var conf_units_droppables = function() {
  $('#conf_units tr').droppable({
    hoverClass: 'drop_hover',
    drop: function(event, ui) {      
      $.ajax({
        type: 'post',
        dataType: 'script',
        data: {
          source: $(ui.draggable).attr('id'),
          target: $(this).attr('id'),
          reorder: $(ui.helper).hasClass('reorder'),
          authenticity_token: window._token
        },
        url: Routing.drop_conf_units_url()
      });
    }
  });

  $('#conf_units tr ._move').draggable({
    revert: 'invalid',
    helper: function() {
      return "<div class='helper'>"+$(this).attr('rel')+"</div>"
    },
    drag: function(event, ui) {
      if (event.altKey) {
        $(ui.helper).addClass('reorder');
      } else {
        $(ui.helper).removeClass('reorder');
      }
    }
  });
};

// Можно оформить в widget.
DynAttr = {
  initialize: function(tpl, count) {
    DynAttr.tpl = tpl;
    DynAttr.count = count;
    $('#dyn_attr_clone').click(function(e) {
      e.preventDefault();
      DynAttr.clone();
    });
    $('#dyn_attrs ._delete').live('click', function(e) {
      e.preventDefault();
      $(this)
        .parents('._dyn_attr')
        .hide()
        .find('._delete_field')
        .val('1');
    });
  },
  clone: function() {
    DynAttr.count += 1;
    $('#dyn_attrs').append(DynAttr.tpl.split('%index%').join(DynAttr.count));
  },
  tpl: null,
  count: 0
};